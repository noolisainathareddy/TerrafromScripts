resource "aws_eks_cluster" "nkit_eks_cluster" {
  name = "${var.eks_cluster_name}_${var.env}"
  access_config {
    authentication_mode = var.eks_authentication_mode
  }
  compute_config {
    enabled = var.eks_auto_mode
  }
  kubernetes_network_config {
    elastic_load_balancing {
      enabled = var.eks_auto_mode
    }
  }

  storage_config {
    block_storage {
      enabled = var.eks_auto_mode
    }
  }
  role_arn = var.cluster_role_arn
  version = var.aws_eks_version
  vpc_config {
    subnet_ids = var.list_of_subnets   
  }
  tags = merge({ Name = "${var.eks_cluster_name}_${var.env}"}, var.tags)
}

