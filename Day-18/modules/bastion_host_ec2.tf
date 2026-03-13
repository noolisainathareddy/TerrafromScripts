resource "aws_instance" "bastion_host" {
    ami =  "ami-02dfbd4ff395f2a1b"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.nkit_public_subnet_1a.id
    vpc_security_group_ids = [aws_security_group.public_sg.id]
    key_name = "east-1"
    tags = {
      Name = "Bastion-host"
    }
    associate_public_ip_address = true
}