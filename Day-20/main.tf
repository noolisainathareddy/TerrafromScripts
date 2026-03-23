module "aws_vpc" {
  source            = "./module/VPC"
  tags              = var.tags
  vpc_instance_type = var.vpc_instance_type
  env               = var.env
  vpc_cidr          = var.vpc_cidr
  azs               = local.azs
  subnet_cidr       = var.subnet_cidr
  default_subnet_cidr = var.default_subnet_cidr
}