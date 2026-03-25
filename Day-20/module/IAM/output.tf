output "eks_cluster_role_arn" {
  value = aws_iam_role.nkit_eks_cluster_role.arn
}

output "eks_node_role_arn" {
  value = aws_iam_role.nkit_eks_node_role.arn
}