resource "aws_eip" "elastic-ip" {
  vpc = true
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.elastic-ip.id
  subnet_id     = var.id-sub-pub

  tags = {
    Name = var.name-nat-gateway
  }
  depends_on = [var.igw-depends]
}
