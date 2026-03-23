locals {
  azs = slice(data.aws_availability_zones.active_zones.names, 0, 2)
}