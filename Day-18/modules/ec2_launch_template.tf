resource "aws_launch_template" "nkit_ec2_launch_template" {
  name = "Nkit_Launch_Template"
  image_id = "ami-02dfbd4ff395f2a1b"
  instance_type = "t3.micro"
  key_name = "east-1"
  user_data = filebase64("../start.sh")
}