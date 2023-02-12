resource "aws_instance" "ec2-public" {
  ami           = var.ami-id
  subnet_id     = var.sub-id
  instance_type = var.inst-type
  associate_public_ip_address = var.check
  key_name = var.inst-key
  vpc_security_group_ids = var.sg-pub-id

  connection {
    type = var.connection-type
    host = self.public_ip
    user = var.inst-user
    private_key = file(var.private-key-path)
  }

  provisioner "local-exec" {
    command = "echo ${lookup(self.tags, "Name")}   ${self.private_ip}  ${self.public_ip} >> ./all-ips.txt"
  }

  provisioner "remote-exec" {
    inline = [
      # "sudo yum install http -y",
      # "sudo yum install php -y",
      # "sudo systemctl start httpd",
      # "sudo systemctl start php"
      "sudo apt update -y",
      "sudo apt install nginx -y ",
      "echo 'server {\nlisten 80 default_server;\nlisten [::]:80 default_server;\nserver_name _;\nlocation / {\nproxy_pass http://${var.prv-alb-dns};\n}\n}' > default",
      "sudo mv default /etc/nginx/sites-enabled/default",
      "sudo systemctl restart nginx"
      # "sudo apt update -y",
      # "sudo apt install nginx -y ",
      # "echo 'server { \n listen 80 default_server; \n  listen :80 default_server; \n  server_name _; \n  location / { \n  proxy_pass http://${var.prv-alb-dns}; \n  } \n}' > default",
      # "sudo mv default /etc/nginx/sites-enabled/default",
      # "sudo systemctl restart nginx",
      # "sudo apt install curl -y"
    ]
  }

  tags = {
    Name = var.inst-pub-name
  }
}