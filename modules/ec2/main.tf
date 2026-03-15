resource "aws_instance" "web" {
  count                       = length(var.public_subnets)
  ami                         = var.web_ami
  instance_type               = var.web_instance_type
  subnet_id                   = var.public_subnets[count.index]
  vpc_security_group_ids      = [var.web_sg_id]
  associate_public_ip_address = true
  key_name                    = var.key_name
  tags = {
    Name = "web-${count.index + 1}"
  }
}

resource "aws_instance" "app" {
  count                       = length(var.private_subnets)
  ami                         = var.app_ami
  instance_type               = var.app_instance_type
  subnet_id                   = var.private_subnets[count.index]
  vpc_security_group_ids      = [var.app_sg_id]
  associate_public_ip_address = false
  key_name                    = var.key_name

  tags = {
    Name = "app-${count.index + 1}"
  }
}
