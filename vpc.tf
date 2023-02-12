module "vpc-igw" {
  source = "./vpc-igw"  
  cidr-vpc = "10.0.0.0/16"
  name-vpc = "Dev-VPC"
  name-gateway = "Dev-Gateway"
}

module "public-subnet" {
  source = "./subnet"
  vpc-cidr-block = module.vpc-igw.vpc1-id
  subnet-cidr-blocks = ["10.0.0.0/24","10.0.2.0/24"]
  name-subnet = "dev-public-subnet"
  az-subnet = ["us-east-2a","us-east-2b"]
}

module "private-subnet" {
  source = "./subnet"
  vpc-cidr-block = module.vpc-igw.vpc1-id
  subnet-cidr-blocks = ["10.0.1.0/24","10.0.3.0/24"]
  name-subnet = "dev-private-subnet"
  az-subnet = ["us-east-2a","us-east-2b"]
}

module "nat-gateway" {
  source = "./nat"
  id-sub-pub = module.public-subnet.first-sub
  name-nat-gateway = "dev-nat-gateway"
  igw-depends = module.vpc-igw.igw1-id
}

module "route-tables" {
  source = "./route-tables"
  cidr-of-vpc = module.vpc-igw.vpc1-id
  pub-ip = "0.0.0.0/0"
  ip-igw = module.vpc-igw.igw1-id
  public-route-table-name = "dev-public-route-tb"
  ip-nat-igw = module.nat-gateway.nat1-id
  private-route-table-name = "dev-private-route-tb"
  sub-ip-ass-pub  = [module.public-subnet.first-sub,module.public-subnet.second-sub]
  sub-ip-ass-priv = [module.private-subnet.first-sub,module.private-subnet.second-sub]
}

