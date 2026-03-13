resource "aws_launch_template" "nkit_ec2_launch_template" {
  name = "Nkit_Launch_Template"
  image_id = "ami-02dfbd4ff395f2a1b"
  instance_type = "t3.micro"
  key_name = "east-1"
  user_data = filebase64("${path.module}/start.sh")
  vpc_security_group_ids = [aws_security_group.private_sg.id]
}