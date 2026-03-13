resource "aws_instance" "web" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_groups
  key_name               = "test"


  tags = {
    Name = "Main EC2 Instance"
  }
}

resource "aws_eip" "ec2_eip" {
  instance = aws_instance.web.id
}
