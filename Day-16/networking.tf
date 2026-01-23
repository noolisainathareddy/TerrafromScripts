resource "aws_vpc" "east_vpc" {
  cidr_block = "12.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  provider = aws.east-1
  tags = {
    name = "east_vpc"
  }
}

resource "aws_vpc" "west_vpc" {
  cidr_block = "13.0.0.0/16"
  provider = aws.west-1
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    name = "west_vpc"
  }
}