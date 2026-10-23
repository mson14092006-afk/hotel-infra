# Region

aws_region = "ap-southeast-1"


# VPC

vpc_cidr = "10.0.0.0/16"


# Subnets

public_subnets = {
  public_a = {
    cidr = "10.0.1.0/24"
    az   = "ap-southeast-1a"
  }

  public_b = {
    cidr = "10.0.2.0/24"
    az   = "ap-southeast-1b"
  }
}

private_app_subnets = {
  private_app_a = {
    cidr = "10.0.3.0/24"
    az   = "ap-southeast-1a"
  }

  private_app_b = {
    cidr = "10.0.4.0/24"
    az   = "ap-southeast-1b"
  }
}

private_db_subnets = {
  private_db_a = {
    cidr = "10.0.5.0/24"
    az   = "ap-southeast-1a"
  }

  private_db_b = {
    cidr = "10.0.6.0/24"
    az   = "ap-southeast-1b"
  }
}

# RDS
db_name     = "hotel"
db_username = "postgres"
db_password = "123"