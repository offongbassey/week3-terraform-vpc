# week3-terraform-vpc
# Week 3: Infrastructure as Code (IaC) with Terraform

## 📋 Project Overview
This project demonstrates creating a custom VPC with subnets and routing using Terraform on AWS. Part of my 12-week Cloud Computing journey.

## 🎯 Objectives
- Recreate VPC setup using Infrastructure as Code
- Learn modular design and version control with Terraform
- Automate infrastructure deployment

## 🛠️ Tools & Technologies
- **Terraform** - Infrastructure as Code tool
- **AWS** - Cloud provider
- **VS Code** - Code editor
- **Git/GitHub** - Version control

## 📂 Project Structure
```
week3-terraform-vpc/
├── main.tf              # Main Terraform configuration
├── variables.tf         # Variable definitions
├── outputs.tf           # Output values
├── terraform.tfvars     # Variable values (not tracked in git)
├── .gitignore          # Git ignore file
└── screenshots/         # Documentation screenshots
```

## 🚀 Steps Taken

### Step 1: Set Up Terraform Provider
![Provider Configuration](screenshots/provider-setup.png)

Configured AWS provider with region variable for flexibility.
```hcl
provider "aws" {
  region = var.region
}
```

### Step 2: Create VPC
![VPC Creation](screenshots/vpc-creation.png)

Created custom VPC with CIDR block...

