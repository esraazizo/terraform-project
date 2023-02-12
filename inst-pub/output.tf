output "id-instance-public" {
  value = aws_instance.ec2-public.id
}

output "public-ip-ec2" {
  value = aws_instance.ec2-public.public_ip
}
