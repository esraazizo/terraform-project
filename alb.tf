module "public-load-balancer" {
  source = "./alb"
  alb-name = "public-lb-development"
  subnets-id = [module.public-subnet.first-sub,module.public-subnet.second-sub]
  SG-lb = [module.security-grps.public-sg-id-for-alb]
  lb-type = "application"
  check-internal = false
  name-lb = "public-development-alb" 
  #--------------------------------------------------#
  grp-name-target = "pub-development-target"
  grp-type-target = "instance"
  vpc-id = module.vpc-igw.vpc1-id
  #--------------------------------------------------#
  port-of-instances = 80
  protocol-of-instances = "HTTP"
  #--------------------------------------------------#
  instances-id = [module.pub-instance2.id-instance-public,module.pub-instance1.id-instance-public]
  #--------------------------------------------------#
  lisnter-type = "forward"
  #--------------------------------------------------#
  dependencies = module.pub-instance2
}

module "private-load-balancer" {
  source = "./alb"
  alb-name = "private-lb-development"
  subnets-id = [module.private-subnet.first-sub,module.private-subnet.second-sub]
  SG-lb = [module.security-grps.private-sg-id-for-alb]
  lb-type = "application"
  check-internal = true
  name-lb = "private-development-alb" 
  #--------------------------------------------------#
  grp-name-target = "priv-development-target"
  grp-type-target = "instance"
  vpc-id = module.vpc-igw.vpc1-id
  #--------------------------------------------------#
  port-of-instances = 80
  protocol-of-instances = "HTTP"
  #--------------------------------------------------#
  instances-id = [module.prv-instance1.id-private,module.prv-instance2.id-private]
  #--------------------------------------------------#
  lisnter-type = "forward"
  #--------------------------------------------------#
  dependencies = module.prv-instance2
}