resource "aws_instance" "ec2-private" {
  ami           = var.ami-id
  subnet_id     = var.sub-id
  instance_type = var.inst-type
  associate_public_ip_address = "false"
  provisioner "local-exec" {
    command = "echo ${lookup(self.tags, "Name")}  ${self.private_ip} >> ./all-ips.txt"
  }
  user_data = var.userdata
  vpc_security_group_ids = var.sg-private-id
  tags = {
    Name = var.inst-private-name
  }
  depends_on = [
    var.dependencies
  ]
}