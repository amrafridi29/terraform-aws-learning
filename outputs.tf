
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

output "web_instance_ids" {
  value = module.ec2.web_instance_ids
}
output "app_instance_ids" {
  value = module.ec2.app_instance_ids
}
output "web_public_ips" {
  value = module.ec2.web_public_ips
}

output "alb_dns" {
  value = module.alb.alb_dns
}
# output "rds_endpoint" {
#   value = module.rds.rds_endpoint
# }

