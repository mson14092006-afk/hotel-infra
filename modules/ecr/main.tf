resource "aws_ecr_repository" "main" {
  name                 = "hotel-app"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "hotel-app"
  }
}