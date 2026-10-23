# Target group
resource "aws_lb_target_group" "ecs" {
  name     = "ec2-target-group"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  # default heathcheck

  tags = {
    Name = "ecs-target-group"
  }
}

# Application Load Balancer
resource "aws_lb" "main" {
  name               = "ALB"
  internal           = false
  load_balancer_type = "application"

  security_groups = [var.security_group_id]
  subnets         = var.public_subnet_ids

  tags = {
    Name = "ALB"
  }
}

# ALB Listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn # Gắn listener vào ALB
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs.arn # Forward traffic tới target group
  }
}