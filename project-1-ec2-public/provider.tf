terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.35.1"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Environment = "Learning"
      Project     = "Project 1 (EC2 Public)"
      Team        = "DevOps"
    }
  }
}
