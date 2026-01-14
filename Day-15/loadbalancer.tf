resource "aws_lb_target_group" "nginx-target-group" {
  name        = "nginx-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.nkit-dev-vpc.id
  target_type = "instance"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_lb" "nginx-application-lb" {
  name                       = "nginx-application-lb"
  load_balancer_type         = "application"
  internal                   = false
  subnets                    = [aws_subnet.nkit-dev-public-1a.id, aws_subnet.nkit-dev-public-1b.id]
  security_groups            = [aws_security_group.nkit-dev-public-sg.id]
  enable_deletion_protection = false
}

resource "aws_lb_listener" "nginx-lb-listner" {
  load_balancer_arn = aws_lb.nginx-application-lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx-target-group.arn
  }
}