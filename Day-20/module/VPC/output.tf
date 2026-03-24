output "list_of_subnets" {
  value = aws_subnet.nkit_public_subnet[*].id
}