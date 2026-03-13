module "vpc" {
  source                    = "./modules/vpc"
  cidr_block                = var.cidr_block
  public_subnet_cidr_blocks = var.public_subnet_cidr_blocks
  availability_zones        = var.availability_zones
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.main_vpc_id
}

module "ec2" {
  source              = "./modules/ec2"
  ami                 = var.ami
  instance_type       = var.instance_type
  subnet_id           = module.vpc.public_subnet_id
  vpc_security_groups = [module.sg.ssh_sg_id]
}
