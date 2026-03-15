output "web_instance_ids" {
  value = [for instance in aws_instance.web : instance.id]
}

output "app_instance_ids" {
  value = [for instance in aws_instance.app : instance.id]
}

output "web_public_ips" {
  value = [for instance in aws_instance.web : instance.public_ip]
}
