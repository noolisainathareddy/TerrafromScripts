resource "aws_s3_bucket" "first-bucket" {
  count  = length(var.first_set_of_s3_buckets)
  bucket = var.first_set_of_s3_buckets[count.index]
  tags   = var.tags
}

resource "aws_s3_bucket" "second-bucket" {
  for_each = var.second_set_of_s3_buckets
  bucket   = each.key
  tags     = var.tags

  depends_on = [aws_s3_bucket.first-bucket]
}