resource "aws_ecr_repository" "main" {
  name                 = "${var.environment}-hotel-app"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.environment}-hotel-app"
  }
}