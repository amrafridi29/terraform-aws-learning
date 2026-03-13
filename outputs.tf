output "vpc_id" {
  value = module.vpc.vpc_id
}

output "web_sg_id" {
  value = module.sg.web_sg_id
}

output "web_instance_public_id" {
  value = module.ec2.web_instance_public_id
}

output "ec2_public_dns" {
  value = module.ec2.ec2_public_dns
}


