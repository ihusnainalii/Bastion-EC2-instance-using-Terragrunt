terraform {
  source = "../../../modules/ec2"
}

dependency "vpc" {
  config_path = "../vpc"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  enviroment                          = "prod"
  key_name                            = "bastion-key"
  subnet_id                           = dependency.vpc.outputs.public_subnet_id
  security_group_ids                  = [dependency.vpc.outputs.security_group_id]
}
