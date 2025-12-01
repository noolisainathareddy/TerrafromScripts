module "EC2" {
  source = "./module/ec2"
}

module "s3" {
  source = "./module/s3"
}