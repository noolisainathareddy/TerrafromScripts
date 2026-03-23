terraform {
  required_version = ">= 1.12"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = ">= 6.00"
    }
  }
  backend "s3" {
    profile = "kubeadmin"
    encrypt = true
    key = "day20/terraform.tfstate"
    bucket = "sai-nooli-terraform-day15"
    use_lockfile = true
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
  profile = "kubeadmin"
}