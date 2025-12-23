resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = lower(replace(var.ec2_instace_type, "-", "."))
  tags          = merge(var.common-tags, var.specific-tags)
}

