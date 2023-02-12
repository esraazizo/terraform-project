output "public-sg-id-for-ec2" {
  value = aws_security_group.security-grp-instance-pub.id
}

output "private-sg-id-for-ec2" {
  value = aws_security_group.security-grp-instance-private.id
}

output "public-sg-id-for-alb" {
  value = aws_security_group.security-grp-public-alb.id
}

output "private-sg-id-for-alb" {
  value = aws_security_group.security-grp-private-alb.id
}