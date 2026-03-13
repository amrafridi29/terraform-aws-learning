output "web_instance_id" {
  value = aws_instance.web.id
}

output "ec2_public_dns" {
  value = aws_instance.web.public_dns
}

output "ec2_public_ip" {
  value = aws_eip.ec2_eip.public_ip
}

output "server_instance_id" {
  value = aws_instance.server.id
}
