resource "aws_route_table" "public-table" {
  vpc_id = var.cidr-of-vpc

  route {
    cidr_block = var.pub-ip
    gateway_id = var.ip-igw
  } 
  
  tags = {
    Name = var.public-route-table-name
  }
}

resource "aws_route_table" "private-table" {
  vpc_id = var.cidr-of-vpc

  route {
    cidr_block = var.pub-ip
    nat_gateway_id = var.ip-nat-igw
  } 
  
  tags = {
    Name = var.private-route-table-name
  }
}

resource "aws_route_table_association" "route-table-one" {
  count = length(var.sub-ip-ass-pub)
  subnet_id      = var.sub-ip-ass-pub[count.index]
  route_table_id = aws_route_table.public-table.id
}

resource "aws_route_table_association" "route-table-two" {
  count = length(var.sub-ip-ass-priv)
  subnet_id      = var.sub-ip-ass-priv[count.index]
  route_table_id = aws_route_table.private-table.id
}