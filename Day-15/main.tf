

resource "aws_launch_template" "nkit_dev_instance" {
  name          = "nkit-dev-private"
  description   = "Creating private ec2 instances"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = "nkit-dev-sai1996"
}