# VPC

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR value"
}

# Subnets

variable "public_subnets" {
  description = "Public subnets"

  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "private_app_subnets" {
  description = "Private app subnets"

  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "private_db_subnets" {
  description = "Private DB subnets"

  type = map(object({
    cidr = string
    az   = string
  }))
}


