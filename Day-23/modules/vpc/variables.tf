variable "nkit_vpc_cidr" {
  type=string
}

variable "tags" {
  type = map(string)
}

variable "resource_tags" {
  type = map(string)
  default = {
    name = "nkit_vpc"
    env  = "dev"
  }
}