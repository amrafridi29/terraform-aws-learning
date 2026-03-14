
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

module "ec2" {
  source            = "./modules/ec2"
  web_ami           = var.web_ami
  web_instance_type = var.web_instance_type
  web_sg_id         = module.security_groups.web_sg_id

  app_ami           = var.app_ami
  app_instance_type = var.app_instance_type
  app_sg_id         = module.security_groups.app_sg_id

  public_subnets  = module.vpc.public_subnets
  private_subnets = module.vpc.private_subnets

  key_name = var.key_name
}
