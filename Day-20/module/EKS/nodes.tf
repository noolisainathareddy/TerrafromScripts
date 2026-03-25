resource "aws_eks_node_group" "nkit_eks_node_group" {
  cluster_name = aws_eks_cluster.nkit_eks_cluster.name
  node_group_name = var.eks_node_group_name
  node_role_arn = var.node_role_arn
  subnet_ids = var.list_of_subnets
  scaling_config {
    desired_size = var.eks_node_desired_size
    max_size = var.eks_node_max_size
    min_size = var.eks_node_min_size
  }
  launch_template {
    id = var.eks_node_launch_template
  }
}