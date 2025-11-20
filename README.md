# week3-terraform-vpc

## Section 1: Git Initialization and First Commit

The screenshot below documents the setup of Git for this project. It shows the initialization of the repository, staging of files, and the first commit. It also includes the resolution of a Git identity error by configuring the global username and email.

![Git Setup Screenshot](screenshots/Screenshot%202025-11-16%20173527.png)

# Week 3 Terraform VPC Project

This project uses Terraform to build a secure and scalable Virtual Private Cloud (VPC) on AWS. It includes public and private subnets, an internet gateway, a NAT gateway, route tables, security groups, and EC2 instances.

## 📦 Project Structure

- `main.tf` — Core infrastructure resources (VPC, subnets, gateways, EC2 instances)
- `variables.tf` — Input variable definitions (region, instance type, AMI ID)
- `terraform.tfvars` — Actual values for the variables
- `outputs.tf` — Displays useful info after deployment (like public IP)
- `README.md` — Documentation for setup and usage

## 🚀 How to Deploy

1. **Initialize Terraform**
   ```bash
   terraform init
