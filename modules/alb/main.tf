# Target group
resource "aws_lb_target_group" "ecs" {
  name     = "${var.environment}-ecs-target-group"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip" # Sử dụng IP của ECS tasks thay vì instance ID

  # default heathcheck

  tags = {
    Name = "${var.environment}-ecs-target-group"
  }
}

# Application Load Balancer
resource "aws_lb" "main" {
  name               = "${var.environment}-ALB"
  internal           = false
  load_balancer_type = "application"

  security_groups = [var.security_group_id]
  subnets         = var.public_subnet_ids

  tags = {
    Name = "${var.environment}-ALB"
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
#  resourece "aws_lb_listener" "https" {
#   load_balancer_arn = aws_lb.main.arn
#   port              = 443
#   protocol          = "HTTPS"

#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = var.certificate_arn # ARN của ACM certificate

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.ecs.arn
#   }
# }