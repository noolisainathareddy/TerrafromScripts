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

variable "node_role_Arn" {
  type = string
}

variable "list_of_subnets" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}