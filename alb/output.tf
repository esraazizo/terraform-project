output "dns-of-alb-prv" {
  value = aws_lb.webapp-alb.dns_name
}