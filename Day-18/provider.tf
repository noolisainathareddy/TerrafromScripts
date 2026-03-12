terraform {
  required_version = ">= 1.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
  }
  backend "s3" {
    use_lockfile = true
    bucket       = "sai-nooli-terraform-day15"
    key          = "day18/terraform.tfstate"
    encrypt      = true
    region       = "us-east-1"
  }
}


provider "aws" {
  region  = "us-east-1"
  profile = "sai1996"
}