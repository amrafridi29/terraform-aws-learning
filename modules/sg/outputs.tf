output "web_sg_id" {
  value = aws_security_group.web_sg.id
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "private_server_sg_id" {
  value = aws_security_group.server_sg.id
}
