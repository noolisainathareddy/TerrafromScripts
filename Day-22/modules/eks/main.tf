resource "aws_eks_cluster" "rover_dev_eks_cluster" {
    provider = aws.primary_east
    name = "rover-dev-eks-cluster"
  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }
  compute_config {
    enabled = false
  }
  kubernetes_network_config {
    elastic_load_balancing {
      enabled = false
    }
  }

  storage_config {
    block_storage {
      enabled = false
    }
  }
  
  role_arn = "arn:aws:iam::886436933815:role/eksClusterRole"
  version = "1.34"
  vpc_config {
    subnet_ids = var.subnet_ids
  }
  tags = {
    Name = "rover_dev_eks_cluster"
  }
  
}

resource "aws_eks_addon" "rover_dev_eks_cluster_csi" {
  cluster_name = aws_eks_cluster.rover_dev_eks_cluster.name
  addon_name = "aws-ebs-csi-driver"
  resolve_conflicts_on_create = "OVERWRITE"
  addon_version = "v1.58.0-eksbuild.1"
  service_account_role_arn = "arn:aws:iam::886436933815:role/AmazonEKS_EBS_CSI_DriverRole"
}


data "tls_certificate" "eks_oidc" {
  url = aws_eks_cluster.rover_dev_eks_cluster.identity[0].oidc[0].issuer
}


resource "aws_iam_openid_connect_provider" "rove_dev_eks_oidc" {
  url = aws_eks_cluster.rover_dev_eks_cluster.identity[0].oidc[0].issuer

  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = [
    data.tls_certificate.eks_oidc.certificates[0].sha1_fingerprint
  ]
  
}

resource "aws_eks_node_group" "rover_dev_eks_node_group" {

  provider = aws.primary_east
   scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

  cluster_name    = aws_eks_cluster.rover_dev_eks_cluster.id
  node_group_name = "eks_dev_node_group"
  node_role_arn   = "arn:aws:iam::886436933815:role/eksNodeRole"
  subnet_ids      = var.subnet_ids

   update_config {
    max_unavailable = 1
  }
  
tags = {
  Name = "rover_dev_node_group"
}

}

resource "aws_eks_access_entry" "aws_eks_access_entry_sai1996" {
  provider = aws.primary_east
  cluster_name = aws_eks_cluster.rover_dev_eks_cluster.name
  principal_arn = "arn:aws:iam::886436933815:user/sai1996"
  type              = "STANDARD"
}

resource "aws_eks_access_policy_association" "eks_access_policy_association_sai1996" {
    provider = aws.primary_east
  cluster_name  = aws_eks_cluster.rover_dev_eks_cluster.name
  policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = "arn:aws:iam::886436933815:user/sai1996"
  access_scope {
    type = "cluster"
  }
}
