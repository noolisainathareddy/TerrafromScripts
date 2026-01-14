resource "aws_vpc" "nkit-dev-vpc" {
  cidr_block       = var.vpc_cidr_range
  instance_tenancy = var.vpc_instance_tenancy
  tags = {
    Name = "nkit-dev-vpc"
  }
}

resource "aws_subnet" "nkit-dev-public-1a" {
  availability_zone = "us-east-1a"
  vpc_id            = aws_vpc.nkit-dev-vpc.id
  cidr_block        = var.nkit-dev-public-1a-cidr
  tags = {
    Name = "nkit-dev-public-1a"
  }
  depends_on = [aws_vpc.nkit-dev-vpc]
}

resource "aws_subnet" "nkit-dev-public-1b" {
  availability_zone = "us-east-1b"
  vpc_id            = aws_vpc.nkit-dev-vpc.id
  cidr_block        = var.nkit-dev-public-1b-cidr
  tags = {
    Name = "nkit-dev-public-1b"
  }
  depends_on = [aws_vpc.nkit-dev-vpc]
}

resource "aws_subnet" "nkit-dev-private-1a" {
  availability_zone = "us-east-1a"
  vpc_id            = aws_vpc.nkit-dev-vpc.id
  cidr_block        = var.nkit-dev-private-1a-cidr
  tags = {
    Name = "nkit-dev-private-1a"
  }
  depends_on = [aws_vpc.nkit-dev-vpc]
}

resource "aws_subnet" "nkit-dev-private-1b" {
  availability_zone = "us-east-1b"
  vpc_id            = aws_vpc.nkit-dev-vpc.id
  cidr_block        = var.nkit-dev-private-1b-cidr
  tags = {
    Name = "nkit-dev-private-1b"
  }
  depends_on = [aws_vpc.nkit-dev-vpc]
}

resource "aws_internet_gateway" "nkit-dev-igw" {
  vpc_id = aws_vpc.nkit-dev-vpc.id
  tags = {
    Name = "nkit-dev-igw"
  }
  depends_on = [aws_vpc.nkit-dev-vpc]
}

resource "aws_eip" "elastic_ip" {
  domain     = "vpc"
  depends_on = [aws_vpc.nkit-dev-vpc]

}

resource "aws_nat_gateway" "nkit-dev-nat" {
  subnet_id         = aws_subnet.nkit-dev-public-1a.id
  availability_mode = "zonal"
  allocation_id     = aws_eip.elastic_ip.id
  tags = {
    Name = "nkit-dev-nat"
  }
  depends_on = [aws_internet_gateway.nkit-dev-igw, aws_eip.elastic_ip]
}

resource "aws_route_table" "nkit-dev-private-rt" {
  vpc_id = aws_vpc.nkit-dev-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nkit-dev-nat.id
  }
  tags = {
    Name = "nkit-dev-private-rt"
  }
  depends_on = [aws_vpc.nkit-dev-vpc]
}

resource "aws_route_table" "nkit-dev-public-rt" {
  vpc_id = aws_vpc.nkit-dev-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nkit-dev-igw.id
  }
  tags = {
    Name = "nkit-dev-public-rt"
  }
  depends_on = [aws_vpc.nkit-dev-vpc]
}


resource "aws_route_table_association" "public_rt_association-1a" {
  subnet_id      = aws_subnet.nkit-dev-public-1a.id
  route_table_id = aws_route_table.nkit-dev-public-rt.id
}


resource "aws_route_table_association" "public_rt_association-1b" {
  subnet_id      = aws_subnet.nkit-dev-public-1b.id
  route_table_id = aws_route_table.nkit-dev-public-rt.id
}

resource "aws_route_table_association" "private_rt_association-1a" {
  subnet_id      = aws_subnet.nkit-dev-private-1a.id
  route_table_id = aws_route_table.nkit-dev-private-rt.id
}


resource "aws_route_table_association" "private_rt_association-1b" {
  subnet_id      = aws_subnet.nkit-dev-private-1b.id
  route_table_id = aws_route_table.nkit-dev-private-rt.id
}


resource "aws_security_group" "nkit-dev-public-sg" {
  name   = "nkit-dev-public-sg"
  vpc_id = aws_vpc.nkit-dev-vpc.id
  tags = {
    Name = "nkit-dev-public-sg"
  }
  depends_on = [aws_vpc.nkit-dev-vpc]
}

resource "aws_security_group" "nkit-dev-private-sg" {
  name   = "nkit-dev-private-sg"
  vpc_id = aws_vpc.nkit-dev-vpc.id
  tags = {
    Name = "nkit-dev-private-sg"
  }
  depends_on = [aws_vpc.nkit-dev-vpc]
}

resource "aws_vpc_security_group_ingress_rule" "nkit-dev-public-ingress-rule" {
  security_group_id = aws_security_group.nkit-dev-public-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "nkit-dev-public-egress-rule" {
  security_group_id = aws_security_group.nkit-dev-public-sg.id
    ip_protocol = "-1"
    cidr_ipv4 = "0.0.0.0/0"
}


resource "aws_vpc_security_group_ingress_rule" "nkit-dev-private-ingress-rule-http" {
  security_group_id = aws_security_group.nkit-dev-private-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
}


resource "aws_vpc_security_group_ingress_rule" "nkit-dev-private-ingress-rule-ssh" {
  security_group_id = aws_security_group.nkit-dev-private-sg.id
  cidr_ipv4         = "14.0.0.0/16"
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}


resource "aws_network_acl" "nkit-dev-public-nacl" {
  vpc_id = aws_vpc.nkit-dev-vpc.id
  ingress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    from_port  = 0
    to_port    = 0
    cidr_block = "0.0.0.0/0"
  }
  egress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    from_port  = 0
    to_port    = 0
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = "nkit-dev-public-nacl"
  }
}


resource "aws_network_acl_association" "nkit-dev-public-1a" {
  subnet_id      = aws_subnet.nkit-dev-public-1a.id
  network_acl_id = aws_network_acl.nkit-dev-public-nacl.id
  depends_on     = [aws_network_acl.nkit-dev-public-nacl]
}

resource "aws_network_acl_association" "nkit-dev-public-1b" {
  subnet_id      = aws_subnet.nkit-dev-public-1b.id
  network_acl_id = aws_network_acl.nkit-dev-public-nacl.id
  depends_on     = [aws_network_acl.nkit-dev-public-nacl]
}

resource "aws_network_acl" "nkit-dev-private-nacl-ssh" {
  vpc_id = aws_vpc.nkit-dev-vpc.id
  ingress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    from_port  = 0
    to_port    = 0
    cidr_block = "0.0.0.0/0"
  }
  egress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    from_port  = 0
    to_port    = 0
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = "nkit-dev-private-nacl-ssh"
  }
}


resource "aws_network_acl_association" "nkit-dev-private-1a" {
  subnet_id      = aws_subnet.nkit-dev-private-1a.id
  network_acl_id = aws_network_acl.nkit-dev-private-nacl-ssh.id
}

resource "aws_network_acl_association" "nkit-dev-private-1b" {
  subnet_id      = aws_subnet.nkit-dev-private-1b.id
  network_acl_id = aws_network_acl.nkit-dev-private-nacl-ssh.id
}




