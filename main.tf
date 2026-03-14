
module "vpc" {
  source             = "./modules/vpc"
  name               = "vpc"
  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  availability_zones = var.availability_zones
}
