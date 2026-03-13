resource "aws_instance" "web" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = var.vpc_security_groups
  key_name               = var.key_name


  tags = {
    Name = "Web Instance"
  }
}

resource "aws_instance" "server" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.private_subnet_id
  vpc_security_group_ids      = var.vpc_security_groups
  key_name                    = var.key_name
  associate_public_ip_address = false

  tags = {
    Name = "Server Instance"
  }

}

resource "aws_eip" "ec2_eip" {
  instance = aws_instance.web.id
}


