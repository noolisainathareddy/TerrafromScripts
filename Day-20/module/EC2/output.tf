output "eks_node_launch_template_id" {
  value = aws_launch_template.eks_node_template.id
}

output "eks_node_launch_template_version" {
    value = aws_launch_template.eks_node_template.latest_version
}