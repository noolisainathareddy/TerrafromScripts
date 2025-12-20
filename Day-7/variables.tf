variable "allowed_region" {
  type        = set(string)
  description = "AWS region for US East"
  default     = ["us-east-1", "us-west-2", "eu-west-1"]
}

variable "ec2_instance_count" {
  type = number
}

variable "ec2_ami_id" {
  type    = string
  default = "ami-069e612f612be3a2b"
}

variable "allowed_ec2_instance_type" {
  type    = list(string)
  default = ["t2.micro", "t2.small", "t3.micro", "t3.small"]
}

variable "cidr_blocks" {
  type    = list(string)
  default = ["10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]
}

variable "tags" {
  type = map(string)
  default = {
    "Environment" = "Dev"
    "Owner"       = "Sai-Nooli"
  }
}

variable "ec2_attributes" {
  type    = tuple([string, number, string])
  default = ["value", 0, "value"]
}