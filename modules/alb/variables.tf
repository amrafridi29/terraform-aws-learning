variable "public_subnets" {
  type = list(string)
}

variable "alb_security_groups" {
  type = list(string)
}

variable "instance_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}
