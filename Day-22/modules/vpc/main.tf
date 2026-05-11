resource "aws_vpc" "rover_vpc_east" {
  provider = aws.primary_east
  cidr_block = var.vpc_cidr
  tags = {
    Name =  "${var.vpc_resource_name}_${var.env}"
  }
}

resource "aws_internet_gateway" "rover_dev_igw" {
  provider = aws.primary_east
  vpc_id = aws_vpc.rover_vpc_east.id
  tags = {
    Name = "rove_dev_igw"
  }
}

resource "aws_subnet" "rover_public_subent-1a" {
  map_public_ip_on_launch = true
  vpc_id = aws_vpc.rover_vpc_east.id
  availability_zone = "us-east-1a"
  provider = aws.primary_east
  cidr_block = "11.0.10.0/24"
  tags = {
    Name =  "rover_dev_public_subnet_1a"
  }
}

resource "aws_subnet" "rover_public_subent-1b" {
  map_public_ip_on_launch = true
  vpc_id = aws_vpc.rover_vpc_east.id
  availability_zone = "us-east-1b"
  provider = aws.primary_east
  cidr_block = "11.0.20.0/24"
  tags = {
    Name =  "rover_dev_public_subnet_1b"
  }
}

resource "aws_route_table" "rover_dev_rt" {
  vpc_id = aws_vpc.rover_vpc_east.id
  provider = aws.primary_east
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.rover_dev_igw.id
  }
  tags = {
    Name = "rover_dev_rt"
  }

}

resource "aws_route_table_association" "route_table_association_1a" {
  provider = aws.primary_east
  route_table_id = aws_route_table.rover_dev_rt.id
  subnet_id = aws_subnet.rover_public_subent-1a.id
}

resource "aws_route_table_association" "route_table_association_1b" {
  provider = aws.primary_east
  route_table_id = aws_route_table.rover_dev_rt.id
  subnet_id = aws_subnet.rover_public_subent-1b.id
}

resource "aws_security_group" "rover_dev_sg" {
  provider = aws.primary_east
  name = "rover_dev_sg"
  vpc_id = aws_vpc.rover_vpc_east.id
  tags = {
    Name = "rover_dev_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "rover_dev_sg_ingress" {
  provider = aws.primary_east
  security_group_id = aws_security_group.rover_dev_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "rover_dev_sg_egress" {
  provider = aws.primary_east
  security_group_id = aws_security_group.rover_dev_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_network_acl" "rover_dev_nacl" {
  vpc_id = aws_vpc.rover_vpc_east.id
  provider = aws.primary_east
  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "rover_dev_nacl"
  }
}

resource "aws_network_acl_association" "network_acl_association_subnet_1a" {
  provider = aws.primary_east
  network_acl_id = aws_network_acl.rover_dev_nacl.id
  subnet_id = aws_subnet.rover_public_subent-1a.id
}

resource "aws_network_acl_association" "network_acl_association_subnet_1b" {
    provider = aws.primary_east
  network_acl_id = aws_network_acl.rover_dev_nacl.id
  subnet_id = aws_subnet.rover_public_subent-1b.id
}