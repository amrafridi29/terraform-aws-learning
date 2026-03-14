
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}
output "private_subnets" {
  value = module.vpc.private_subnets
}
output "db_subnets" {
  value = module.vpc.db_subnets
}

output "web_sg_id" {
  value = module.security_groups.web_sg_id
}

output "app_sg_id" {
  value = module.security_groups.app_sg_id
}
output "db_sg_id" {
  value = module.security_groups.db_sg_id
}
