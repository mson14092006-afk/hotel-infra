# Environment

environment = "dev"

# Region

aws_region = "ap-southeast-1"


# VPC

vpc_cidr = "10.10.0.0/16"


# Subnets

public_subnets = {
  public_a = {
    cidr = "10.10.1.0/24"
    az   = "ap-southeast-1a"
  }

  public_b = {
    cidr = "10.10.2.0/24"
    az   = "ap-southeast-1b"
  }
}

private_app_subnets = {
  private_app_a = {
    cidr = "10.10.3.0/24"
    az   = "ap-southeast-1a"
  }
}

private_db_subnets = {
  private_db_a = {
    cidr = "10.10.5.0/24"
    az   = "ap-southeast-1a"
  }

  private_db_b = {
    cidr = "10.10.6.0/24"
    az   = "ap-southeast-1b"
  }
}

# RDS
db_name              = "hotel"
db_username          = "postgres"
db_password          = "123"
db_availability_zone = "ap-southeast-1a"
db_multi_az          = false

# ECS
ecs_desired_count = 1 