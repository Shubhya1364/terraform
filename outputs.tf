outputs.tf  # Output Values for Terraform Configuration
# Author: Shubhya | Cloud & DevOps Engineer
# These outputs export important resource information for use by other systems

# VPC Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

# Subnet Outputs
output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private[*].id
}

# Security Group Outputs
output "web_security_group_id" {
  description = "ID of the web server security group"
  value       = aws_security_group.web_sg.id
}

# EC2 Instance Outputs
output "web_server_ids" {
  description = "List of EC2 instance IDs"
  value       = aws_instance.web_server[*].id
}

output "web_server_public_ips" {
  description = "List of public IP addresses of web servers"
  value       = aws_instance.web_server[*].public_ip
}

output "web_server_private_ips" {
  description = "List of private IP addresses of web servers"
  value       = aws_instance.web_server[*].private_ip
}

# S3 Bucket Outputs
output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.app_bucket.id
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.app_bucket.arn
}

output "s3_bucket_domain_name" {
  description = "Domain name of the S3 bucket"
  value       = aws_s3_bucket.app_bucket.bucket_domain_name
}

# Application Load Balancer Outputs (conditional)
output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = var.enable_alb ? aws_lb.app_lb[0].dns_name : null
}

output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = var.enable_alb ? aws_lb.app_lb[0].arn : null
}

output "alb_zone_id" {
  description = "Zone ID of the Application Load Balancer"
  value       = var.enable_alb ? aws_lb.app_lb[0].zone_id : null
}

output "target_group_arn" {
  description = "ARN of the target group"
  value       = var.enable_alb ? aws_lb_target_group.app_tg[0].arn : null
}

# Deployment Information
output "deployment_region" {
  description = "AWS region where resources are deployed"
  value       = var.aws_region
}

output "environment" {
  description = "Environment name"
  value       = var.environment
}

output "project_name" {
  description = "Project name"
  value       = var.project_name
}

# Application Access URL
output "application_url" {
  description = "URL to access the application"
  value       = var.enable_alb ? "http://${aws_lb.app_lb[0].dns_name}" : "http://${aws_instance.web_server[0].public_ip}"
}

# Summary Output
output "deployment_summary" {
  description = "Summary of the deployed infrastructure"
  value = {
    vpc_id              = aws_vpc.main.id
    public_subnets      = length(aws_subnet.public)
    private_subnets     = length(aws_subnet.private)
    web_servers         = length(aws_instance.web_server)
    load_balancer       = var.enable_alb
    s3_bucket          = aws_s3_bucket.app_bucket.id
    environment        = var.environment
    region             = var.aws_region
  }
}
