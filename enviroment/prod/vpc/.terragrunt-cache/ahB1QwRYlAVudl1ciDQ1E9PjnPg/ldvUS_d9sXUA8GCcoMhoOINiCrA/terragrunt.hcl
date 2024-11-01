terraform {
  source = "../../../modules/vpc"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  enviroment                          = "prod"
  instance_region                     = "us-east-1"
  security_group_ingress_cidr_block   = "0.0.0.0/0"
}