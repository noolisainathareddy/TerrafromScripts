resource "aws_instance" "ease_instance" {
  provider      = aws.east-1
  key_name      = "day27-east"
  ami           = "ami-0532be01f26a3de55"
  instance_type = "t3.micro"
  tags = {
    Name = "east_instance"
  }
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.east_subnet.id
  vpc_security_group_ids      = [aws_security_group.east_sg.id]
  depends_on                  = [aws_security_group.east_sg, aws_subnet.east_subnet]
}

resource "aws_instance" "west_instance" {
  provider      = aws.west-1
  key_name      = "day27-west"
  ami           = "ami-0993d3759749c153c"
  instance_type = "t3.micro"
  tags = {
    Name = "west_instance"
  }
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.west_subnet.id
  vpc_security_group_ids      = [aws_security_group.west_sg.id]

  depends_on = [aws_security_group.west_sg, aws_subnet.west_subnet]
}