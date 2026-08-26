module "module_vpc" {
  source = "../../modules/vpc"
}

module "module_iam" {
  source = "../../modules/IAM"
}

module "module_eks" {
  source = "../../modules/eks"

  cluster_name     = "consumer-app-eks"
  subnet_ids       = module.module_vpc.public_subnet_ids
  cluster_role_arn = module.module_iam.eks_cluster_role_arn
  node_role_arn    = module.module_iam.eks_node_role_arn

  # Ensure the managed policies are attached to the roles before the
  # cluster / node group try to use them.
  depends_on = [module.module_iam]
}
