output "public_ip_ec2" {
  value = module.EC2.public_ip
}

output "private_ip_ec2" {
  value = module.EC2.private_ip
}
