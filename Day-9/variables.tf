variable "ec2_ami_id" {
  type    = string
  default = "ami-069e612f612be3a2b"
}

variable "allowed_instace_types" {
  type    = list(string)
  default = ["t3.micro", "t2.micro", "t4.micro"]
}

variable "tags" {
  type = map(string)
  default = {
    "Env"     = "Dev"
    "CreadBy" = "Terraform"
    "Unit"    = "OrgLevel"
    "AppName" = "TestingKit"
  }
}