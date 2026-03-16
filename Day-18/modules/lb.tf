resource "aws_lb_target_group" "nkit_dev_target_group" {
  name = "nkit-dev-target-group"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_autoscaling_attachment" "nkit_dev_target_group" {
  lb_target_group_arn = aws_lb_target_group.nkit_dev_target_group.arn
  autoscaling_group_name = aws_autoscaling_group.nkit_auto_scaling_group.id
}