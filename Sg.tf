module "security-grps" {
  source = "./security-groups"
  #---Security Groups of public-EC2
  SG-pub-name = "public-EC2-SG"
  SG-pub-desc = "Public Instances Security Group Allow SSH & HTTP"
  #------------------------
  vpc-cidr-block-id = module.vpc-igw.vpc1-id
  port-http = 80
  port-ssh = 22
  tcp-protocol = "tcp"
  cidr-public-of-traffics = ["0.0.0.0/0"]
  port-all-traffic = 0
  all-traffic-protocol = "-1"
  #------------------------
  SG-public-tags = "public-security-group-EC2"
  #---Security Groups of private-EC2
  SG-private-name ="private-EC2-SG"
  SG-private-desc = "Private Instances Security Group Allow HTTP From Private ALB SG"
  SG-private-tags = "private-security-group-EC2"
  #---Security Groups of public-alb
  SG-alb-name = "public-ALB-SG"
  SG-alb-desc = "Public ALB Security Group Allow SSH & HTTP"
  SG-alb-public-tags = "public-security-group-ALB"
  #---Security Groups of private-alb
  SG-private-alb-name = "private-ALB-SG"
  SG-private-alb-desc = "Private Instances Security Group Allow HTTP From Public EC2 SG"
  SG-private-alb-tags = "private-security-group-ALB"
}