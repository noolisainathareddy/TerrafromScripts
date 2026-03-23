resource "aws_vpc" "nkit_vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = var.vpc_instance_type
  tags = merge(
    {Name =  "Nkit_VPC_${var.env}" },
    var.tags
  )
}

resource "aws_subnet" "nkit_subnet_1" {
  count = length(var.subnet_cidr)
  vpc_id = aws_vpc.nkit_vpc.id
  cidr_block = var.subnet_cidr[count.index]
  availability_zone = var.azs[count.index]
  tags = merge({
    Name = "Nkit_subnet_${count.index + 1 }"
  }, var.tags)
}