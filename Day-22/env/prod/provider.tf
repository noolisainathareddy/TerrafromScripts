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
      bucket = "terraform-state-file-versions-sai"
      key = "prod/terraform.tfstate"
      region = "us-east-1"
      profile = "sai1996"
    }
}

provider "aws" {
  alias = "primary_east"
  region = "us-east-1"
}

provider "aws" {
  alias = "secondary_west"
  region = "us-west-1"
}