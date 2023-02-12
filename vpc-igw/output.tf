output "vpc1-id" {
  value = aws_vpc.admin-vpc.id
}

output "igw1-id" {
  value = aws_internet_gateway.igw.id
}