variable "env" {
  type = string
}

variable "eks_cluster_name" {
  type = string
}

variable "eks_authentication_mode" {
  type = string
}

variable "cluster_role_arn" {
  type = string
}

variable "node_role_arn" {
  type = string
}

variable "list_of_subnets" {
  type = list(string)
}

variable "tags" {
  type = map(string)
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

variable "eks_node_launch_template_id" {
  type = string
}

variable "eks_node_launch_template_version" {
  type = string
}

variable "eks_auto_mode" {
  type = bool
}

variable "aws_eks_version" {
  type = string
}