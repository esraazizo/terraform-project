
data "aws_ami" "amazon-os" {
  most_recent      = true
  owners           = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}


module "prv-instance1" {
  source = "./inst-priv"
  ami-id = data.aws_ami.amazon-os.image_id
  inst-type = "t2.micro"
  sub-id = module.private-subnet.first-sub
  sg-private-id = [module.security-grps.private-sg-id-for-ec2]
  inst-private-name = "private-inst-1"
  dependencies = module.nat-gateway
  userdata =  <<EOF
    #!/bin/bash
    # install httpd (Linux Version2)
    yum update -y
    yum -y install httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Hello Esraa! $(hostname -f)<h1>" > /var/www/html/index.html
  EOF
}


module "prv-instance2" {
  source = "./inst-priv"
  ami-id = data.aws_ami.amazon-os.image_id
  inst-type = "t2.micro"
  sub-id = module.private-subnet.second-sub
  sg-private-id = [module.security-grps.private-sg-id-for-ec2]
  inst-private-name = "private-inst-2"
  dependencies = module.nat-gateway
  userdata =  <<EOF
    #!/bin/bash
    # install httpd (Linux Version2)
    yum update -y
    yum -y install httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Hello Esraa-2 ! $(hostname -f)<h1>" > /var/www/html/index.html
  EOF
}