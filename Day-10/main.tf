resource "aws_instance" "ec2_instance" {
  count         = var.ec2_count
  ami           = var.ami_id
  instance_type = var.tags.Env == "Dev" ? var.allowed_instace_types[0] : var.allowed_instace_types[1]
  tags          = var.tags
}

resource "aws_security_group" "forst-sg" {
  name = "Allow_TLS"

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = var.tags
}