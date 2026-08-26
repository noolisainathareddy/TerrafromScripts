terraform {
    required_version = ">= 1.10"
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
      }
    }
    backend "s3" {
      encrypt = true
      use_lockfile = true
      profile = "sai1996"
      bucket = "terraform-state-file-versions-sai"
      key = "day24/dev/terraform.tfstate"
      region = "us-east-1"
    }
}

provider "aws" {
  profile = "sai1996"
  region = "us-east-1"
}