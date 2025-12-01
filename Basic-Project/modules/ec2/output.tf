output "public_ip" {
    value = aws_instance.Linux_VM.public_ip
}

output "private_ip" {
    value = aws_instance.Linux_VM.private_ip
}