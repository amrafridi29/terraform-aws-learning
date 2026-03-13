module "vpc" {
  source                     = "./modules/vpc"
  cidr_block                 = var.cidr_block
  public_subnet_cidr_blocks  = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
  availability_zones         = var.availability_zones
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source              = "./modules/ec2"
  ami                 = var.ami
  instance_type       = var.instance_type
  public_subnet_id    = module.vpc.public_subnet_1_id
  private_subnet_id   = module.vpc.private_subnet_1_id
  vpc_security_groups = [module.sg.web_sg_id]
  key_name            = var.key_name
}

module "alb" {
  source              = "./modules/alb"
  instance_ids        = [module.ec2.web_instance_id, module.ec2.server_instance_id]
  public_subnets      = [module.vpc.public_subnet_1_id, module.vpc.public_subnet_2_id]
  alb_security_groups = [module.sg.alb_sg_id]
  vpc_id              = module.vpc.vpc_id
}
