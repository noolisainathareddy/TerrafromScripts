variable "ami_id" {
  type    = string
  default = "ami-069e612f612be3a2b"
  validation {
    condition     = length(var.ami_id) >= 20
    error_message = "AMI ID is in-correct"
  }
}

variable "ec2_instace_type" {
  type    = string
  default = "T3-MICRO"
}

variable "common-tags" {
  type = map(string)
  default = {
    "Name"      = "Python-app"
    "CreatedBy" = "Terraform"
  }
}

variable "specific-tags" {
  type = map(string)
  default = {
    "Env" = "Dev"
  }
}


