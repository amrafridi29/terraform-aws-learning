variable "ami" {
  description = "EC2 instance ami"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet id"
  type        = string
}

variable "private_subnet_id" {
  description = "Pivate subnet id"
  type        = string
}

variable "vpc_security_groups" {
  description = "VPC security groups"
  type        = list(string)
}

variable "key_name" {
  description = "SSH key name"
  type        = string
}
