# ☁️ Terraform Infrastructure as Code

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)
![IaC](https://img.shields.io/badge/IaC-Infrastructure_as_Code-green?style=for-the-badge)

## 📝 Overview

Infrastructure as Code (IaC) implementation using Terraform for automating cloud infrastructure provisioning and management. This project demonstrates proficiency in declarative infrastructure configuration, resource management, and cloud automation using HashiCorp Terraform.

## ✨ Features

- **Multi-Cloud Support**: Infrastructure provisioning across AWS, Azure, and GCP
- **Modular Architecture**: Reusable Terraform modules for scalability
- **State Management**: Remote state storage with locking mechanism
- **Version Control**: Infrastructure versioning and change tracking
- **Environment Separation**: Distinct configurations for dev, staging, and production
- **Automated Provisioning**: Reproducible infrastructure deployment
- **Resource Tagging**: Organized resource management with consistent tagging

## 🛠️ Technologies Used

- **Terraform**: v1.5+ (Infrastructure as Code tool)
- **AWS**: Cloud provider (EC2, VPC, S3, RDS, etc.)
- **Terraform Cloud/S3**: Remote state backend
- **Git**: Version control for infrastructure code

## 📁 Project Structure

```
terraform/
├── main.tf                 # Main configuration file
├── variables.tf            # Input variables
├── outputs.tf              # Output values
├── providers.tf            # Provider configurations
├── backend.tf              # Backend configuration
├── terraform.tfvars        # Variable values
├── modules/
│   ├── vpc/                # VPC module
│   ├── ec2/                # EC2 module
│   ├── rds/                # RDS module
│   └── s3/                 # S3 module
├── environments/
│   ├── dev/                # Development environment
│   ├── staging/            # Staging environment
│   └── prod/               # Production environment
└── README.md               # Documentation
```

## 🚀 Getting Started

### Prerequisites

- Terraform (v1.5 or higher)
- AWS CLI configured with credentials
- Git
- Basic understanding of cloud infrastructure

### Installation

1. **Install Terraform**
   ```bash
   # macOS
   brew install terraform
   
   # Verify installation
   terraform version
   ```

2. **Clone the repository**
   ```bash
   git clone https://github.com/Shubhya1364/terraform.git
   cd terraform
   ```

3. **Configure AWS credentials**
   ```bash
   aws configure
   ```

### Usage

#### Initialize Terraform
```bash
# Download providers and initialize backend
terraform init
```

#### Plan Infrastructure Changes
```bash
# Preview changes before applying
terraform plan

# Save plan to file
terraform plan -out=tfplan
```

#### Apply Configuration
```bash
# Apply infrastructure changes
terraform apply

# Apply saved plan
terraform apply tfplan

# Auto-approve (use with caution)
terraform apply -auto-approve
```

#### Destroy Infrastructure
```bash
# Remove all resources
terraform destroy

# Destroy specific resource
terraform destroy -target=aws_instance.example
```

## 💻 Example Configurations

### AWS VPC Module
```hcl
module "vpc" {
  source = "./modules/vpc"
  
  vpc_cidr           = "10.0.0.0/16"
  availability_zones = ["us-east-1a", "us-east-1b"]
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets    = ["10.0.11.0/24", "10.0.12.0/24"]
  
  tags = {
    Environment = "Production"
    Project     = "MyApp"
  }
}
```

### EC2 Instance
```hcl
resource "aws_instance" "web_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  
  vpc_security_group_ids = [aws_security_group.web.id]
  subnet_id              = module.vpc.public_subnets[0]
  
  tags = {
    Name = "WebServer"
    Environment = "Production"
  }
  
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              EOF
}
```

### S3 Bucket with Versioning
```hcl
resource "aws_s3_bucket" "app_data" {
  bucket = "my-app-data-bucket"
  
  versioning {
    enabled = true
  }
  
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  
  tags = {
    Name        = "AppDataBucket"
    Environment = "Production"
  }
}
```

## 🔐 State Management

### Remote Backend Configuration
```hcl
terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}
```

### State Commands
```bash
# List resources in state
terraform state list

# Show specific resource
terraform state show aws_instance.web_server

# Move resource
terraform state mv aws_instance.old aws_instance.new

# Remove resource from state
terraform state rm aws_instance.example
```

## 🎯 Best Practices Implemented

1. **Remote State Storage** - Centralized state with S3 backend
2. **State Locking** - DynamoDB for concurrent access prevention
3. **Modular Design** - Reusable modules for different resources
4. **Variable Files** - Separation of configuration from code
5. **Output Values** - Export important resource attributes
6. **Resource Tagging** - Consistent naming and organization
7. **Version Constraints** - Pinned provider versions
8. **Environment Isolation** - Separate workspaces/directories

## 📊 Terraform Workflow

```
┌─────────────┐
│ Write Code  │
└────┬────────┘
     │
     ↓
┌────┴────────┐
│ terraform   │
│    init     │
└────┬────────┘
     │
     ↓
┌────┴────────┐
│ terraform   │
│    plan     │
└────┬────────┘
     │
     ↓
┌────┴────────┐
│ terraform   │
│    apply    │
└────┬────────┘
     │
     ↓
┌────┴────────┐
│ Infrastructure│
│   Deployed  │
└─────────────┘
```

## 💡 Key Learnings

- Infrastructure as Code principles and benefits
- Terraform configuration language (HCL)
- Resource dependency management
- State file management and best practices
- Module creation and reusability
- Multi-environment infrastructure management
- Cloud resource provisioning and configuration

## 🛠️ Troubleshooting

**State Lock Error**
```bash
# Force unlock (use with caution)
terraform force-unlock <LOCK_ID>
```

**Provider Authentication Issues**
```bash
# Verify AWS credentials
aws sts get-caller-identity

# Set credentials explicitly
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
```

**Resource Already Exists**
```bash
# Import existing resource
terraform import aws_instance.example i-1234567890abcdef0
```

## 📚 Resources

- [Terraform Documentation](https://www.terraform.io/docs)
- [Terraform Registry](https://registry.terraform.io/)
- [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)

## 🎯 Future Enhancements

- [ ] Implement Terraform Cloud integration
- [ ] Add CI/CD pipeline for automated deployments
- [ ] Create custom Terraform modules
- [ ] Implement policy as code with Sentinel
- [ ] Add cost estimation with Infracost
- [ ] Multi-cloud deployment strategies

## 💬 Contact

Feel free to reach out for questions or collaboration!

---

**Built with ❤️ by Shubhya | Cloud & DevOps Engineer**
