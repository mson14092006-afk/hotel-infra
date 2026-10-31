# RDS Subnet Group
resource "aws_db_subnet_group" "main" {
  name       = "${var.environment}-rds-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.environment}-rds-subnet-group"
  }
}

# RDS 
resource "aws_db_instance" "main" {
  identifier     = "${var.environment}-my-blog-db"
  multi_az       = var.db_multi_az
  availability_zone = var.db_availability_zone
  engine         = "postgres"
  engine_version = "17"

  instance_class = "db.t3.micro"

  allocated_storage = 20 # GB
  storage_type      = "gp3" # gp3 yêu cầu ít nhất 20GB

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.security_group_id]

  publicly_accessible = false

  skip_final_snapshot = true
}