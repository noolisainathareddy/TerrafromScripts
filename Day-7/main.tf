resource "aws_instance" "ec2-day7-instances" {
  count         = var.ec2_instance_count
  ami           = var.ec2_ami_id
  instance_type = var.allowed_ec2_instance_type[2]
  tags = {
    Name       = "day7-ec3-instance"
    created_by = "Terraform"
  }
}

resource "aws_vpc" "first-vpc" {
  cidr_block = var.cidr_blocks[0]
  tags = merge(var.tags, {
    Name       = "day7-vpc"
    created_by = "Terraform"
  })
}

resource "aws_subnet" "first-subnet" {
  vpc_id     = aws_vpc.first-vpc.id
  cidr_block = var.cidr_blocks[1]
  tags = {
    Name       = "First-subnet"
    created_by = "Terraform"
  }
}

resource "aws_subnet" "second-subnet" {
  vpc_id     = aws_vpc.first-vpc.id
  cidr_block = var.cidr_blocks[2]
  tags = {
    Name       = "Second-subnet"
    created_by = "Terraform"
  }
}

