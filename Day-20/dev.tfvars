vpc_cidr            = "11.0.0.0/16"
vpc_instance_type   = "default"
tags                = { env = "dev", app = "nkit", createdBy = "terraform" }
env                 = "dev"
subnet_cidr         = ["11.0.10.0/24", "11.0.20.0/24"]
default_subnet_cidr = "0.0.0.0/0"
sg_ip_protocol      = "-1"