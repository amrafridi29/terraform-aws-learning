variable "region" {
  description = "The region to deploy the infrastructure"
  type        = string
  default     = "us-east-2"
}

variable "cidr_block" {
  description = "Main VPC cidr block ip"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_blocks" {
  description = "Public subnets cidr blocks ip addresses"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "private_subnet_cidr_blocks" {
  description = "Priate subnets cidr blocks ip addresses"
  type        = list(string)
  default     = ["10.0.101.0/24"]
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-east-2a", "us-east-2b"]
}

variable "ami" {
  description = "EC2 instance ami"
  type        = string
  default     = "ami-0b0b78dcacbab728f"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "SSH key name"
  type        = string
  default     = "test"
}
