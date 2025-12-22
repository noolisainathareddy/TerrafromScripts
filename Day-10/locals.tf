locals {
  all_instace_ids = aws_instance.ec2_instance[*].id
}