output "vpc_id" {
  value = aws_vpc.public_vpc.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.public_subnet_1a.id,
    aws_subnet.public_subnet_1b.id,
  ]
}
