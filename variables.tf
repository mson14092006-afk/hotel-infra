# Region

variable "aws_region" {
  type = string
}


# VPC

variable "vpc_cidr" {
  description = " VPC CIDR"
  type        = string
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

# RDS
variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}
variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}