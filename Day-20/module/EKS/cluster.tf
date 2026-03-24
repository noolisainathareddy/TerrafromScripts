resource "aws_eks_cluster" "nkit_eks_cluster" {
  name = "${var.eks_cluster_name}_${var.env}"
  access_config {
    authentication_mode = var.eks_authentication_mode
  }
  role_arn = var.cluster_role_arn
  version = "1.34"
  vpc_config {
    subnet_ids = var.list_of_subnets   
  }
  tags = merge({ Name = "${var.eks_cluster_name}_${var.env}"}, var.tags)
}

