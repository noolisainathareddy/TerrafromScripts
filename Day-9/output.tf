output "ec2_private_ip" {
  value = aws_instance.ec2_instance_east_1.private_ip
}