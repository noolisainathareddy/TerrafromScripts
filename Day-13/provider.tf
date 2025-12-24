terraform {
  required_version = ">= 1.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.4"
    }
  }
  backend "s3" {
    bucket       = "sai-nooli-terraform-day7"
    key          = "day-13/dev/terraform.tfstate"
    use_lockfile = true
    encrypt      = true
    region       = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}
