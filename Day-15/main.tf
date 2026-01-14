resource "aws_launch_template" "nkit_dev_instance" {
  name                   = "nkit-dev-private"
  description            = "Creating private ec2 instances"
  image_id               = var.ami_id
  instance_type          = var.instance_type
  key_name               = "nkit-dev-sai1996"
  vpc_security_group_ids = [aws_security_group.nkit-dev-private-sg.id]
  user_data              = filebase64("script.sh")
}

resource "aws_instance" "bastion-host" {
  key_name      = "nkit-dev-sai1996"
  ami           = "ami-068c0051b15cdb816"
  instance_type = "t3.micro"
  tags = {
    Name = "Bastion-Host"
  }
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.nkit-dev-public-1a.id
  vpc_security_group_ids      = [aws_security_group.nkit-dev-public-sg.id]
}

resource "aws_autoscaling_group" "nkit-dev-auto-scale-grp" {
  name = "nkit-dev-auto-scale-grp"
  launch_template {
    id = aws_launch_template.nkit_dev_instance.id
  }
  target_group_arns   = [aws_lb_target_group.nginx-target-group.arn]
  max_size            = 4
  min_size            = 1
  desired_capacity    = 2
  vpc_zone_identifier = [aws_subnet.nkit-dev-private-1a.id, aws_subnet.nkit-dev-private-1b.id]
}