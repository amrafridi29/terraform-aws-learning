
module "vpc" {
  source             = "./modules/vpc"
  name               = "prod-vpc"
  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  db_subnets         = var.db_subnets
  availability_zones = var.availability_zones
}

module "security_groups" {
  source = "./modules/security_groups"
  name   = "prod-security-group"
  vpc_id = module.vpc.vpc_id
}
