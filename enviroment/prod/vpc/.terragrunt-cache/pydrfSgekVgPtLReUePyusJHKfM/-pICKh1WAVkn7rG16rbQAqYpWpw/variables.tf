variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_a_cidr" {
  description = "CIDR block for the subnet A"
  type        = string
}

variable "instance_region" {
  description = "region of the instance"
  type        = string
}

variable "enviroment" {
  description = "enviroment name"
  type        = string
}

variable "subnet_b_cidr" {
  description = "CIDR block for the subnet B"
  type        = string
}

variable "security_group_ingress_cidr_block" {
  description = "CIDR block for allowed SSH & HTTP access"
  type        = string
}
