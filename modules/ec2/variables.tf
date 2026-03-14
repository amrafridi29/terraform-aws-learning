variable "public_subnets" {
  type = list(string)
}
variable "private_subnets" {
  type = list(string)
}
variable "web_ami" {
  type = string
}
variable "web_instance_type" {
  type = string
}
variable "app_ami" {
  type = string
}
variable "app_instance_type" {
  type = string
}
variable "web_sg_id" {
  type = string
}
variable "app_sg_id" {
  type = string
}
variable "key_name" {
  type = string
}
