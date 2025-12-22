terraform {
  required_version = ">= 1.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.4"
    }
  }
  backend "s3" {
    bucket       = "sai-nooli-terraform-day7"
    key          = "day-11/dev/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
    region       = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}