variable "name" {
  type = string
}

variable "alb_sg_id" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}
variable "vpc_id" {
  type = string
}

variable "web_instance_ids" {
  type = list(string)
}
