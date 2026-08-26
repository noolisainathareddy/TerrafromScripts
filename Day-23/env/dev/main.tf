module "networking" {
  source = "../../modules/vpc"
  nkit_vpc_cidr = var.nkit_vpc_cidr
  tags = var.tags
  resource_tags = var.resource_tags
  providers = {
    aws.primary = aws.primary
    aws.secondary = aws.secondary
  }
  
}