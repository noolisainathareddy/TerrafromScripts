module "aws_vpc" {
  source              = "./module/VPC"
  tags                = var.tags
  vpc_instance_type   = var.vpc_instance_type
  env                 = var.env
  vpc_cidr            = var.vpc_cidr
  azs                 = local.azs
  subnet_cidr         = var.subnet_cidr
  default_subnet_cidr = var.default_subnet_cidr
  sg_ip_protocol      = var.sg_ip_protocol
}

module "node_launch_template" {
  source                        = "./module/EC2"
  env                           = var.env
  tags                          = var.tags
  aws_launch_template_name      = var.aws_launch_template_name
  aws_launch_template_ami       = var.aws_launch_template_ami
  launch_template_instance_type = var.launch_template_instance_type
  node_ssh_key_name             = var.node_ssh_key_name
}