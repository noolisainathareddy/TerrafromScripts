terraform {
  required_version = ">= 1.10"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

  }
  backend "s3" {
    encrypt      = true
    use_lockfile = true
    key          = "multi-region/terraform.tfstate"
    bucket       = "terraform-state-file-versions-sai"
    region       = "us-east-1"
    profile      = "sai1996"
  }
}

provider "aws" {
  alias   = "primary_east"
  region  = "us-east-1"
  profile = "sai1996"
}

provider "aws" {
  alias   = "secondary_west"
  region  = "us-west-1"
  profile = "sai1996"
}