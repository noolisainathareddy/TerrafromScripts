vpc_cidr                      = "11.0.0.0/16"
vpc_instance_type             = "default"
tags                          = { env = "dev", app = "nkit", createdBy = "terraform" }
env                           = "dev"
subnet_cidr                   = ["11.0.10.0/24", "11.0.20.0/24"]
default_subnet_cidr           = "0.0.0.0/0"
sg_ip_protocol                = "-1"
aws_launch_template_name      = "nkit_eks_node_template"
aws_launch_template_ami       = "ami-0ec10929233384c7f"
launch_template_instance_type = "t2.medium"
node_ssh_key_name             = "east-1"