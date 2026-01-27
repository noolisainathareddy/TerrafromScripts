resource "aws_vpc" "east_vpc" {

  cidr_block           = "12.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  provider             = aws.east-1
  tags = {
    Name = "east_vpc"

  }
}

resource "aws_vpc" "west_vpc" {
  cidr_block           = "13.0.0.0/16"
  provider             = aws.west-1
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "west_vpc"
  }
}

resource "aws_subnet" "east_subnet" {
  cidr_block        = "12.0.10.0/24"
  vpc_id            = aws_vpc.east_vpc.id
  availability_zone = "us-east-1a"
  provider          = aws.east-1
  tags = {
    Name = "east_subnet"
  }
}

resource "aws_subnet" "west_subnet" {
  provider          = aws.west-1
  vpc_id            = aws_vpc.west_vpc.id
  cidr_block        = "13.0.10.0/24"
  availability_zone = "us-west-1b"
  tags = {
    Name = "west_subent"
  }
}


resource "aws_internet_gateway" "east_igw" {
  vpc_id   = aws_vpc.east_vpc.id
  provider = aws.east-1
  tags = {
    Name = "east_igw"
  }
}

resource "aws_internet_gateway" "west_igw" {
  vpc_id   = aws_vpc.west_vpc.id
  provider = aws.west-1
  tags = {
    Name = "west_igw"
  }
}


resource "aws_route_table" "east_rt" {
  vpc_id   = aws_vpc.east_vpc.id
  provider = aws.east-1
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.east_igw.id
  }
  tags = {
    Name = "east_rt"
  }
}

resource "aws_route_table_association" "east_subnet_rt_association" {
  subnet_id      = aws_subnet.east_subnet.id
  provider       = aws.east-1
  route_table_id = aws_route_table.east_rt.id
}

resource "aws_route_table_association" "west_subnet_rt_association" {
  subnet_id      = aws_subnet.west_subnet.id
  provider       = aws.west-1
  route_table_id = aws_route_table.west_rt.id
}


resource "aws_route_table" "west_rt" {
  vpc_id   = aws_vpc.west_vpc.id
  provider = aws.west-1
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.west_igw.id
  }

  tags = {
    Name = "west_rt"
  }
}

resource "aws_security_group" "east_sg" {
  name        = "east_sg"
  description = "Allow all traffic"
  vpc_id      = aws_vpc.east_vpc.id
  provider    = aws.east-1
  tags = {
    Name = "east_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "east_allow_all_ingress_traffic" {
  security_group_id = aws_security_group.east_sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  depends_on        = [aws_security_group.east_sg]
}

resource "aws_vpc_security_group_egress_rule" "east_allow_all_egress_traffic" {
  security_group_id = aws_security_group.east_sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  depends_on        = [aws_security_group.east_sg]
}

resource "aws_security_group" "west_sg" {
  name        = "west_sg"
  description = "allow all trafic"
  vpc_id      = aws_vpc.west_vpc.id
  provider    = aws.west-1
  tags = {
    Name = "west_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "west_allow_all_ingress_traffic" {
  security_group_id = aws_security_group.west_sg.id
  provider          = aws.west-1
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  depends_on        = [aws_security_group.west_sg]
}

resource "aws_vpc_security_group_egress_rule" "west_allow_all_egress_traffic" {
  security_group_id = aws_security_group.west_sg.id
  provider          = aws.west-1
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  depends_on        = [aws_security_group.west_sg]
}

resource "aws_vpc_peering_connection" "east_to_west_peering" {
  provider    = aws.east-1
  vpc_id      = aws_vpc.east_vpc.id
  peer_vpc_id = aws_vpc.west_vpc.id
  peer_region = "us-west-1"
  auto_accept = false
  tags = {
    Name = "east_to_west_peering"
  }
}

resource "aws_vpc_peering_connection_accepter" "west_to_east_peering" {
  provider                  = aws.west-1
  vpc_peering_connection_id = aws_vpc_peering_connection.east_to_west_peering.id
  auto_accept               = true
  tags = {
    Side = "Accepter"
    Name = "west_to_east_accepter"
  }
  depends_on = [aws_vpc_peering_connection.east_to_west_peering]
}

resource "aws_route" "east_to_west_routing" {
  route_table_id            = aws_route_table.east_rt.id
  provider                  = aws.east-1
  destination_cidr_block    = "13.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.east_to_west_peering.id

  depends_on = [aws_vpc_peering_connection_accepter.west_to_east_peering]
}

resource "aws_route" "west_to_east_routing" {
  route_table_id            = aws_route_table.west_rt.id
  provider                  = aws.west-1
  destination_cidr_block    = "12.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.east_to_west_peering.id
}