

resource "aws_vpc" "main_vpc" {
 cidr_block = var.vpc_cidr_block
 instance_tenancy = var.instance_tenancy
 tags = merge(var.tags,{
    "Name" = "${var.app}-vpc"
 })
 enable_dns_hostnames = var.enable_dns_hostnames
}
resource "aws_subnet" "nkit_public_subnet_1a" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.0.10.0/24"
  availability_zone = "us-east-1a"
  tags = merge(var.tags,{
    "Name" = "nkit_public_subnet_1a"
 })
}

resource "aws_subnet" "nkit_public_subnet_1b" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.0.20.0/24"
  availability_zone = "us-east-1b"
  tags = merge(var.tags,{
    "Name" = "nkit_public_subnet_1b"
 })
}

resource "aws_eip" "eip_1a" {
  domain = "vpc"
  tags = merge(var.tags,{
    "Name" = "eip_1a"
 })
}

resource "aws_nat_gateway" "nkit_nat_gateway_1a" {
  subnet_id = aws_subnet.nkit_public_subnet_1a.id
  connectivity_type = "public"
  availability_mode = "zonal"
  allocation_id = aws_eip.eip_1a.id
  tags = merge(var.tags,{
    "Name" = "nkit_nat_gateway_1a"
 })
}

resource "aws_eip" "eip_1b" {
  domain = "vpc"
  tags = merge(var.tags,{
    "Name" = "eip_1b"
 })
}

resource "aws_nat_gateway" "nkit_nat_gateway_1b" {
  subnet_id = aws_subnet.nkit_public_subnet_1b.id
  availability_mode = "zonal"
  connectivity_type = "public"
  allocation_id = aws_eip.eip_1b.id
  tags = merge(var.tags,{
    "Name" = "nkit_nat_gateway_1b"
 })
}

resource "aws_subnet" "nkit_private_subnet_1a" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.0.80.0/24"
  availability_zone = "us-east-1a"
  tags = merge(var.tags,{
    "Name" = "nkit_private_subnet_1a"
 })
}

resource "aws_subnet" "nkit_private_subnet_1b" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.0.90.0/24"
  availability_zone = "us-east-1b"
  tags = merge(var.tags,{
    "Name" = "nkit_private_subnet_1b"
 })
}

resource "aws_internet_gateway" "nkit_igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = merge(var.tags,{
    "Name" = "nkit_igw"
 })
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.main_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.nkit_igw.id
    }
    tags = merge(var.tags,{
    "Name" = "public_rt"
 })
}

resource "aws_route_table_association" "associate_public_rt_subnet_1a" {
  subnet_id = aws_subnet.nkit_public_subnet_1a.id
  route_table_id = aws_route_table.public_rt.id
  
}

resource "aws_route_table_association" "associate_public_rt_subnet_1b" {
  subnet_id = aws_subnet.nkit_public_subnet_1b.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt_1a" {
    vpc_id = aws_vpc.main_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nkit_nat_gateway_1a.id
    }
    tags = merge(var.tags,{
    "Name" = "private_rt_1a"
 })
}

resource "aws_route_table" "private_rt_1b" {
    vpc_id = aws_vpc.main_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nkit_nat_gateway_1b.id
    }
    tags = merge(var.tags,{
    "Name" = "private_rt_1b"
 })
}

resource "aws_route_table_association" "associate_private_rt_subnet_1a" {
  subnet_id = aws_subnet.nkit_private_subnet_1a.id
  route_table_id = aws_route_table.private_rt_1a.id
}

resource "aws_route_table_association" "associate_private_rt_subnet_1b" {
  subnet_id = aws_subnet.nkit_private_subnet_1b.id
  route_table_id = aws_route_table.private_rt_1b.id
}


resource "aws_security_group'" "public_sg" {
  
}

resource "aws_security_group" "name" {
  
}