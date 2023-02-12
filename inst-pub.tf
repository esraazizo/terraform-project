data "aws_ami" "ubuntu" {
    most_recent = true
    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
    owners = ["099720109477"]
}
#----------------------------Public Modules
module "pub-instance1" {
  source = "./inst-pub"
  ami-id = data.aws_ami.ubuntu.image_id
  inst-type = "t2.micro"
  sub-id = module.public-subnet.first-sub
  check = "true"
  inst-key = "key1"
  connection-type = "ssh"
  inst-user = "ubuntu"
  private-key-path = "/home/esraa/Downloads/key1.pem"
  sg-pub-id = [module.security-grps.public-sg-id-for-ec2]
  inst-pub-name = "public-inst-1"
  prv-alb-dns = module.private-load-balancer.dns-of-alb-prv
  }

module "pub-instance2" {
  source = "./inst-pub"
  ami-id = data.aws_ami.ubuntu.image_id
  inst-type = "t2.micro"
  sub-id = module.public-subnet.second-sub
  check = "true"
  inst-key = "key1"
  connection-type = "ssh"
  inst-user = "ubuntu"
  private-key-path = "/home/esraa/Downloads/key1.pem"
  sg-pub-id = [module.security-grps.public-sg-id-for-ec2]
  inst-pub-name = "public-inst-2"
  prv-alb-dns = module.private-load-balancer.dns-of-alb-prv
}
#----------------------------Private Modules

