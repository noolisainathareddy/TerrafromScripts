

resource "aws_launch_template" "nkit_dev_instance" {
  name          = "nkit-dev-private"
  description   = "Creating private ec2 instances"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = "nkit-dev-sai1996"
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