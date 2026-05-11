resource "aws_vpc" "rover_vpc_east" {
  provider = aws.primary_east
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Rover_VPC_Dev"
  }
}