resource "aws_s3_bucket" "test_bucket" {
    bucket = "sai-test-nov-30"
    tags = {
      Name = "Sai-Dev"
      Environment = "Dev"
    }
}