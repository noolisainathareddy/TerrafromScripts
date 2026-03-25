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

variable "azs" {
  type = list(string)
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

variable "eks_node_desired_size" {
  type = number
}

variable "eks_node_max_size" {
  type = number
}

variable "eks_node_min_size" {
  type = number
}

variable "eks_node_launch_template" {
  type = string
}