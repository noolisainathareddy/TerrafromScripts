variable "ami_id" {
  type    = string
  default = "ami-069e612f612be3a2b"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "proj-tags" {
  type = map(string)
  default = {
    "CreatedBy" = "Terraform"
  }
}

variable "aws-tags" {
  type = map(string)
  default = {
    "Env" = "Dev"
  }
}

variable "proj-name" {
  default = "Project ALPHA Resource"
}


variable "s3-bucket-name" {
  default = "sai DAY11 dec2123456789876543"
}
