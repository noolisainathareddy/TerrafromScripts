resource "aws_vpc" "nkit_vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = var.vpc_instance_type
  tags = merge(
    {Name =  "Nkit_VPC_${var.env}" },
    var.tags
  )
}

resource "aws_internet_gateway" "nkit_igw" {
  vpc_id = aws_vpc.nkit_vpc.id
  tags = merge(
    {
      Name = "nkit_igw_${var.env}"
    },
    var.tags
  )
}

resource "aws_subnet" "nkit_public_subnet" {
  count = length(var.subnet_cidr)
  vpc_id = aws_vpc.nkit_vpc.id
  cidr_block = var.subnet_cidr[count.index]
  availability_zone = var.azs[count.index]
  tags = merge({
    Name = "Nkit_public_subnet_${count.index + 1 }"
  }, var.tags)
}

resource "aws_route_table" "nkit_rt" {
  vpc_id = aws_vpc.nkit_vpc.id
  route {
    cidr_block = var.default_subnet_cidr
    gateway_id = aws_internet_gateway.nkit_igw.id
  }
}