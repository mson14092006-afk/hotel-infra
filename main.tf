module "networking" {
  source              = "./modules/networking"
  vpc_cidr            = var.vpc_cidr
  public_subnets      = var.public_subnets
  private_app_subnets = var.private_app_subnets
  private_db_subnets  = var.private_db_subnets
}

module "security" {
  source = "./modules/security"

  vpc_id = module.networking.vpc_id # Lấy VPC ID từ networking module
}

module "alb" {
  source = "./modules/alb"

  vpc_id = module.networking.vpc_id

  security_group_id = module.security.alb_security_group_id
  # Lấy security group ID từ outputs của security module

  public_subnet_ids = module.networking.public_subnet_ids # already list
}

module "ecr" {
  source = "./modules/ecr"
}

module "ecs" {
  source = "./modules/ecs"

  ecr_repository_url = "${module.ecr.ecr_repository_url}:v1"

  security_group_id = module.security.ecs_security_group_id

  private_subnet_ids = module.networking.private_app_subnet_ids

  target_group_arn = module.alb.target_group_arn
}

module "rds" {
  source = "./modules/rds"

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password

  private_subnet_ids = module.networking.private_db_subnet_ids

  security_group_id = module.security.rds_security_group_id
}