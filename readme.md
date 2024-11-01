# Bastion EC2 Instance Setup with Terragrunt

This project configures a Bastion EC2 instance and VPC for both `dev` and `prod` environments using Terragrunt. Each environment has separate Terragrunt configuration files to manage distinct settings for EC2 and VPC resources.

## Project Structure

```plaintext
.
├── environment
│   ├── dev
│   │   ├── ec2
│   │   │   └── terragrunt.hcl
│   │   └── vpc
│   │       └── terragrunt.hcl
│   └── prod
│       ├── ec2
│       │   └── terragrunt.hcl
│       └── vpc
│           └── terragrunt.hcl
├── modules
│   ├── ec2
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── vpc
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
└── terragrunt.hcl
