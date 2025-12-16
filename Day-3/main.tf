terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
  }
  required_version = ">1.5"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my-third-bucket" {
  bucket = "my-third-bucket-sai123-day3"

  tags = {
    Name        = "my-third-bucket"
    Environment = "Dev"
  }
}