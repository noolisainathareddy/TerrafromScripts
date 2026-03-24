output "eks_cluster_role_Arn" {
  value = aws_iam_role.nkit_eks_cluster_role.arn
}

output "eks_node_role_Arn" {
  value = aws_iam_role.nkit_eks_node_role.arn
}