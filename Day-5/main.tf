terraform {
  required_version = ">= 1.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
  }
  backend "s3" {
    bucket       = "sai-nooli-terraform-day5"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}

variable "environment" {
  default = "dev"
}

variable "cidr" {
  type = string
}


locals {
  ami-id        = "ami-069e612f612be3a2b"
  instance_type = "t3.micro"
}

output "ec2_private_ip" {
  value = aws_instance.ec3-day-5.private_ip
}

resource "aws_instance" "ec3-day-5" {
  ami           = local.ami-id
  instance_type = local.instance_type

  tags = {
    Environment = var.environment
  }
}

resource "aws_vpc" "custom_vpc" {
  cidr_block = var.cidr

  tags = {
    Environment = var.environment
  }
}