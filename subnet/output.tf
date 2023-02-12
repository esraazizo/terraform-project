output "first-sub" {
  value = aws_subnet.my-subnets[0].id
}

output "second-sub" {
  value = aws_subnet.my-subnets[1].id
}