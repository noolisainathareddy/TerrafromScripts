resource "aws_instance" "Linux_VM" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name        = "nkit-tokyo"
  security_groups = ["default"]
  tags = {
    Name = "nkit-tokyo"
  }
}