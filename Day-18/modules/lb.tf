resource "aws_lb_target_group" "nkit_dev_target_group" {
  name = "nkit_dev_target_group"
  port = 80
  protocol = "HTTP"
  target_type = "ip"
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_lb_target_group_attachment" "nkit_dev_target_group" {
  target_group_arn = aws_lb_target_group.nkit_dev_target_group.arn
  target_id = aws_autoscaling_group.nkit_auto_scaling_group.id
}