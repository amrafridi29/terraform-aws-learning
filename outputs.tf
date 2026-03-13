output "vpc_id" {
  value = module.vpc.vpc_id
}

output "web_sg_id" {
  value = module.sg.web_sg_id
}

output "ec2_public_ip" {
  value = module.ec2.ec2_public_ip
}

output "ec2_public_dns" {
  value = module.ec2.ec2_public_dns
}


