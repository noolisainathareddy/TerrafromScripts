variable "env" {
  type = string
}

variable "tags" {
  type = map(string)
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