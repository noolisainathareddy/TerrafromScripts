variable "ami_id" {
  type    = string
  default = "ami-069e612f612be3a2b"
}

variable "allowed_instace_types" {
  type    = list(string)
  default = ["t3.micro", "t2.micro"]
}

variable "tags" {
  type = map(string)

  default = {
    "Env"       = "Dev"
    "CreatedBy" = "Terraform"
  }
}

variable "ec2_count" {
  type = number
}

variable "egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)

  }))
  default = [{
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["10.10.10.0/24"]
  }]
}