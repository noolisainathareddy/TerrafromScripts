module "vpc" {
  source = "../../modules/vpc"
  providers = {
    aws.primary_east   = aws.primary_east
    aws.secondary_west = aws.secondary_west
  }
  env               = var.env
  vpc_resource_name = var.vpc_resource_name
  vpc_cidr          = var.vpc_cidr
}

module "eks" {
  source = "../../modules/eks"
  providers = {
    aws.primary_east = aws.primary_east
  }
  subnet_ids = [module.vpc.subnet_1a, module.vpc.subnet_1b]

  depends_on = [module.vpc]
}