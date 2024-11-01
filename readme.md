# Bastion EC2 Instance Setup with Terragrunt

This project configures a Bastion EC2 instance and VPC for both `dev` and `prod` environments using Terragrunt. Each environment has separate Terragrunt configuration files to manage distinct settings for EC2 and VPC resources.

## Project Structure

```
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
```

## Prerequisites
To run this terragrunt script, you'll need the following:

- [Terraform](https://developer.hashicorp.com/terraform/install) installed (version 0.12+)
- AWS account and [AWS CLI](https://aws.amazon.com/cli/) configured
- An IAM user with `AdministratorAccess` permissions
- An AWS key pair for EC2 access

## Resources Created

This terragrunt script will create the following resources:

- A VPC with specified CIDR block
- Public and private subnets
- An internet gateway attached to the public subnet
- A NAT gateway for private subnet routing
- Security groups to allow SSH access to the bastion server
- An EC2 instance configured as a bastion server
- Route tables for the public and private subnets

## Features
- **Environment-Specific Configurations**: Separate `terragrunt.hcl` files for `dev` and `prod` environments to manage distinct configurations.
- **Reusable Terraform Modules**: Modularized Terraform code for `ec2` and `vpc` to promote reusability across environments.
- **VPC Setup**: Automatically provisions a VPC with configurable CIDR blocks and subnets.
  - **Customizable CIDR Blocks**: Specify CIDR ranges for VPC, subnets, and security group ingress.
  - **Public Subnets**: Creates subnets that allow public access, ideal for Bastion host setups.
- **EC2 Bastion Host Deployment**: Provisions a Bastion EC2 instance in a specified subnet with access to a security group.
  - **AMI Selection**: Allows for customizable Amazon Machine Image (AMI) selection.
  - **Instance Type**: Configurable instance type for optimizing resources.
  - **Key Pair Association**: Associates an SSH key pair for secure access to the instance.
- **Inter-Module Dependency Management**: Utilizes Terragrunt `dependency` blocks to pass outputs between modules (e.g., using VPC module outputs in EC2 module).
- **Security Group Configuration**: Automatically provisions a security group allowing customizable ingress CIDR for secure access.
- **Automated Networking and Security**: Configures security group rules and subnet associations to ensure secure and organized networking.
- **Flexible Region Selection**: Specify AWS regions per environment for multi-region deployments.
- **Easy Setup and Tear Down**: Simple `terragrunt apply` and `terragrunt destroy` commands for deploying or tearing down resources.
- **Scalable and Maintainable Structure**: Modular and environment-based setup supports scalability and maintainability in multi-environment deployments.


### environment: 
Contains separate `dev` and `prod` folders with Terragrunt configuration files for EC2 and VPC resources.

### modules: 
Reusable Terraform modules for `ec2` and `vpc`.

## Modules
The modules directory contains reusable Terraform configurations for EC2 and VPC.

### EC2 Module (`modules/ec2`)
- main.tf: Defines the EC2 instance resource.
- variables.tf: Contains input variable definitions for the EC2 instance.
- outputs.tf: Defines outputs for the EC2 instance attributes.

### VPC Module (`modules/vpc`)
- main.tf: Defines the VPC, subnets, and security group resources.
- variables.tf: Contains input variable definitions for VPC and networking configurations.
- outputs.tf: Defines outputs for VPC and subnet attributes.

## Usage
- Initialize: Navigate to the environment directory and initialize Terragrunt:
```
cd environment/dev
terragrunt init
```

- Apply: Apply the Terragrunt configuration:
```
terragrunt apply
```

- Destroy: To remove the resources, run:
```
terragrunt destroy
```

## Requirements

- **Terragrunt**: Ensure Terragrunt is installed on your machine.
- **Terraform**: Terraform should also be installed, as Terragrunt relies on it.
- **AWS CLI**: Configure AWS CLI with the appropriate credentials for managing resources.

## Notes

- **AMI, Instance Type, and Key Name**: Update the AMI ID, instance type, and key name in the EC2 configuration files (`terragrunt.hcl`) as needed for your environment.
- **VPC CIDR and Subnet CIDRs**: Modify the VPC and subnet CIDR blocks in the VPC configuration to align with your network design.

This setup creates a basic VPC and deploys a Bastion EC2 instance in the specified subnets, configured for public access.
