variable "cidr_block" {
  description = "Main VPC cidr block ip"
  type        = string
}

variable "public_subnet_cidr_blocks" {
  description = "Public subnets cidr blocks ip addresses"
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
}

variable "private_subnet_cidr_blocks" {
  description = "Priate subnets cidr blocks ip addresses"
  type        = list(string)
}
