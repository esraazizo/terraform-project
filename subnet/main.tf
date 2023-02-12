resource "aws_subnet" "my-subnets" {
  count      = length(var.subnet-cidr-blocks)
  vpc_id     = var.vpc-cidr-block
  cidr_block = var.subnet-cidr-blocks[count.index]
  availability_zone = var.az-subnet[count.index]

  tags = {
    Name = var.name-subnet
  }
}