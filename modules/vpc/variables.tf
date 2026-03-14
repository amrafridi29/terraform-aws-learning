variable "name" {
  description = "Name"
  type        = string
}
variable "vpc_cidr" {
  description = "Vpc cidr block"
  type        = string
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
}

variable "public_subnets" {
  description = "Public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnets"
  type        = list(string)
}

variable "db_subnets" {
  description = "Db subnets"
  type        = list(string)
}

