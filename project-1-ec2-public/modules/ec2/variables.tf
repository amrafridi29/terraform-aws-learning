variable "ami" {
  description = "EC2 instance ami"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Public subnet id"
  type        = string
}

variable "vpc_security_groups" {
  description = "VPC security groups"
  type        = list(string)

}
