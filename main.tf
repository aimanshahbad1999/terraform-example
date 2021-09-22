provider "aws" {
  region = var.region
}

module "vpc"{
  source = "./modules/vpc"
}

module "subnet"{
  source = "./modules/subnet"
  vpc_id = module.vpc.id

}

module "internet_gateway"{
  source = "./modules/internet-gateway"
  vpc_id = module.vpc.id
}

module "route_table"{
  source = "./modules/route-table"
  vpc_id= module.vpc.id
  gateway_id=module.internet_gateway.id
  subnet_id=module.subnet.pub-id
}

module "security_group"{
  source = "./modules/security-group"
  vpc_id = module.vpc.id

}

module "instance"{
  source = "./modules/Ec2"
  subnet_pub_id=module.subnet.pub-id
  subnet_pri_id=module.subnet.pri-id
  security_gp=module.security_group.pub-id

}





