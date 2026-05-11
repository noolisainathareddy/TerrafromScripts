terraform {
    required_version = ">= 1.10"
    required_providers {
      aws = {
        provider = "hashicorp/aws"
        version = ">= 6.1"
      }
    }
    backend "s3" {
      bucket = ""
      key = ""
      region = "us-east-1"
      profile = "sai1996"
      use_lockfile = true
      encrypt = true
    }
}

provider "aws" {
  region = "us-east-1"
}