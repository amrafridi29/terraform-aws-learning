variable "region" {
  description = "The region to deploy the infrastructure"
  type        = string
  default     = "us-east-2"
}

variable "vpc_cidr" {
  description = "Vpc cidr block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-east-2a", "us-east-2b"]
}

variable "public_subnets" {
  description = "Public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "Private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "db_subnets" {
  description = "Db subnets"
  type        = list(string)
  default     = ["10.0.5.0/24", "10.0.6.0/24"]
}

variable "web_ami" {
  type    = string
  default = "ami-0b0b78dcacbab728f"
}
variable "web_instance_type" {
  type    = string
  default = "t2.micro"
}
variable "app_ami" {
  type    = string
  default = "ami-0b0b78dcacbab728f"
}
variable "app_instance_type" {
  type    = string
  default = "t2.micro"
}
variable "key_name" {
  type    = string
  default = "test"
}

variable "db_username" {
  type    = string
  default = "root"
}
variable "db_password" {
  type    = string
  default = "#123AbcD"
}
