resource "aws_vpc" "admin-vpc" {
  cidr_block = var.cidr-vpc
  tags = {
    "Name" = var.name-vpc
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.admin-vpc.id
  tags = {
    Name = var.name-gateway
  }
}
