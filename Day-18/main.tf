locals {
  common_tags = {
    Environment = var.env
    Project     = var.app
    CreatedBy   = var.owner
  }
}

module "app" {
  source               = "./modules"
  vpc_cidr_block       = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  instance_tenancy     = var.instance_tenancy
  tags                 = local.common_tags
  app                  = var.app
}