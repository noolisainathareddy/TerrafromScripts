terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
  }
  backend "s3" {
    bucket       = "sai-nooli-terraform-day15"
    key          = "day16/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
    region       = "us-east-1"
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "sai1996"
}

provider "aws" {
  region  = "us-east-1"
  profile = "sai1996"
  alias   = "east-1"
}

provider "aws" {
  region  = "us-west-1"
  profile = "sai1996"
  alias   = "west-1"
}