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

resource "aws_lb" "nkit_dev_lb" {
  name = "Nkit-dev-lb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.public_sg.id]
  subnets = [aws_subnet.nkit_public_subnet_1a.id, aws_subnet.nkit_public_subnet_1b.id]
}

resource "aws_lb_listener" "nkit_dev_lb_listner" {
  load_balancer_arn = aws_lb.nkit_dev_lb.id
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.nkit_dev_target_group.arn
  }
}