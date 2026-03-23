variable "vpc_cidr" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "vpc_instance_type" {
  type = string
}

variable "env" {
  type = string
}

variable "subnet_cidr" {
  type = list(string)
}

variable "default_subnet_cidr" {
  type = string
}

variable "sg_ip_protocol" {
  type = string
}

variable "aws_launch_template_name" {
  type = string
}

variable "aws_launch_template_ami" {
  type = string
}

variable "launch_template_instance_type" {
  type = string
}

variable "node_ssh_key_name" {
  type = string
}
