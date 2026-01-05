variable "ami_id" {
  default = "ami-068c0051b15cdb816"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "vpc_instance_tenancy" {
  default = "default"
}

variable "vpc_cidr_range" {
  default = "14.0.0.0/16"
}

variable "nkit-dev-public-1a-cidr" {
  default = "14.0.10.0/24"
}

variable "nkit-dev-public-1b-cidr" {
  default = "14.0.20.0/24"
}

variable "nkit-dev-private-1a-cidr" {
  default = "14.0.30.0/24"
}

variable "nkit-dev-private-1b-cidr" {
  default = "14.0.40.0/24"
}