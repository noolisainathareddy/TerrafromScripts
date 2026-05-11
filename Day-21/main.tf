module "vpc" {
  source = "./modules/vpc"
  providers = {
    aws.primary_east = aws.primary_east
  }
  
}