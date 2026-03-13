output "main_vpc_id" {
  value = module.vpc.main_vpc_id
}

output "ssh_sg_id" {
  value = module.sg.ssh_sg_id
}

output "ec2_public_ip" {
  value = module.ec2.ec2_public_ip
}

output "ec2_public_dns" {
  value = module.ec2.ec2_public_dns
}

