terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        configuration_aliases = [ aws.primary, aws.secondary ]
    }
  }
}
resource "aws_vpc" "nkit_vpc" {
    provider = aws.primary
    cidr_block = var.nkit_vpc_cidr
    tags = merge(var.tags, var.resource_tags)
}