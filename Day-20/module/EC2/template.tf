resource "aws_launch_template" "eks_node_template" {
  name = "${var.aws_launch_template_name}_${var.env}"
  image_id = var.aws_launch_template_ami
  instance_type = var.launch_template_instance_type
  key_name = var.node_ssh_key_name
  tags = merge(
    {
      Name = "nkit_eks_node_template${var.env}"
    },
    var.tags
  )
}