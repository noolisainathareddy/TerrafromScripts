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
  depends_on = [ module.aws_vpc ]
}

module "create_iam_role" {
  source                = "./module/IAM"
  eks_cluster_role_name = var.eks_cluster_role_name
  eks_node_role_name    = var.eks_node_role_name
  env                   = var.env
  eks_iam_role_Version  = var.eks_iam_role_Version
  depends_on = [ module.aws_vpc, module.node_launch_template ]
}

module "nkit_eks_cluster" {
  source                  = "./module/EKS"
  eks_cluster_name        = var.eks_cluster_name
  env                     = var.env
  eks_authentication_mode = var.eks_authentication_mode
  list_of_subnets         = module.aws_vpc.list_of_subnets
  cluster_role_arn        = module.create_iam_role.eks_cluster_role_Arn
  node_role_Arn           = module.create_iam_role.eks_node_role_Arn
  tags                    = var.tags
  depends_on = [ module.create_iam_role, module.aws_vpc, module.node_launch_template ]
}

