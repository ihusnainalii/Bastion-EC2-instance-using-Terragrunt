terraform {
  source = "../../../modules/vpc"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  enviroment                          = "dev"
  instance_region                     = "us-east-1"
  security_group_ingress_cidr_block   = "0.0.0.0/0"
  cidr_block                          = "11.0.0.0/16"
  subnet_a_cidr                       = "11.0.0.0/24"
  subnet_b_cidr                       = "11.0.1.0/24"
}