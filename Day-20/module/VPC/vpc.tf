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
  tags = merge({
    Name = "Nkit_public_rt_${var.env}"
  }, var.tags)
}

resource "aws_route_table_association" "subnet_rt_association" {
  count = length(aws_subnet.nkit_public_subnet)
  route_table_id = aws_route_table.nkit_rt.id
  subnet_id = aws_subnet.nkit_public_subnet[count.index].id
}

resource "aws_security_group" "nkit_public_sg" {
  name = "nkit_public_sg_${var.env}"
  vpc_id = aws_vpc.nkit_vpc.id
  tags = merge(
    {
      Name = "nkit_public_sg_${var.env}"
    },var.tags
  )
}

resource "aws_vpc_security_group_egress_rule" "public_sg_egress" {
  security_group_id = aws_security_group.nkit_public_sg.id
  cidr_ipv4 = var.default_subnet_cidr
  ip_protocol = var.sg_ip_protocol
}

resource "aws_vpc_security_group_ingress_rule" "public_sg_ingress" {
  security_group_id = aws_security_group.nkit_public_sg.id
  cidr_ipv4 = var.default_subnet_cidr
  ip_protocol = var.sg_ip_protocol
}

resource "aws_network_acl" "nkit_nacl" {
  vpc_id = aws_vpc.nkit_vpc.id
  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = var.default_subnet_cidr
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = var.default_subnet_cidr
    from_port  = 0
    to_port    = 0
  }
  tags = merge(
    {
      Name = "nkit_nacl_${var.env}"
    },var.tags
  )
}