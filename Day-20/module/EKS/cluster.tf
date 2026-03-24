resource "aws_eks_cluster" "nkit_eks_cluster" {
  name = "${var.eks_cluster_name}_${var.env}"
  access_config {
    authentication_mode = var.eks_authentication_mode
  }
  role_arn = ""
  version = ""
  vpc_config {
    subnet_ids = []
  }
}