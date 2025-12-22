resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags = merge(var.proj-tags, var.aws-tags, {
    "Proj-Name" = lower(replace(var.proj-name, " ", "-"))
  })
}

resource "aws_s3_bucket" "s3-bucket" {
  bucket = lower(replace(substr(var.s3-bucket-name, 0, 15), " ", "-"))
  tags = {
    "Proj-Name" = lower(replace(var.proj-name, " ", "-"))
  }
}