resource "aws_instance" "ec3-day-5" {
  ami           = local.ami_id
  instance_type = local.instace_type

  tags = {
    Environment = var.environment
  }
}

resource "aws_vpc" "custom_vpc" {
  cidr_block = var.cidr

  tags = {
    Environment = var.environment
    ec2_name    = var.ec2_name
  }
}