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

variable "eks_cluster_name" {
  type = string
}

variable "eks_authentication_mode" {
  type = string
}

variable "eks_cluster_role_name" {
  type = string
}

variable "eks_node_role_name" {
  type = string
}

variable "eks_iam_role_Version" {
  type = string
}

variable "eks_node_group_name" {
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

variable "eks_auto_mode" {
  type = bool
}

variable "aws_eks_version" {
  type = string
}