terraform {
    required_version = ">= 1.10"
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = ">= 6.1"
      }
    }
    backend "s3" {
      bucket = "terraform-state-file-versions-sai"
      key = "day23/dev/terraform.tfstate"
      region = "us-east-1"
      profile = "sai1996"
      use_lockfile = true
      encrypt = true
    }
}

provider "aws" {
  profile = "sai1996"
  alias = "primary"
  region = "us-east-1"
}

provider "aws" {
  profile = "sai1996"
  alias = "secondary"
  region = "us-west-1"
}