# resource "aws_instance" "ec2_instance" {

# }

data "aws_vpc" "dev_vpc_id" {
    region = "us-east-1"
    cidr_block = "14.0.0.0/16"
  filter {
    name = "tag:Name"
    values = ["nkit-vpc"]
  }
}