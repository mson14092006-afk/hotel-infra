# Task definition
resource "aws_ecs_task_definition" "main" {
  family                   = "hotel-app"
  requires_compatibilities = ["FARGATE"] # chạy tương thích với loại hạ tầng Fargate
  network_mode             = "awsvpc"

  cpu    = 512  # CPU units = 0.5 vCPU
  memory = 1024 # MiB

  execution_role_arn = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([
    {
      name      = "hotel-app"
      image     = var.ecr_repository_url
      essential = true # Nếu container này dừng, ECS sẽ dừng toàn bộ task

      portMappings = [
        {
          containerPort = 5000
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs" # Dùng driver của AWS để chuyển log lên CloudWatch Logs
        options = {
          "awslogs-group"         = "/ecs/hotel-app" # log group trong CloudWatch Logs
          "awslogs-region"        = "ap-southeast-1" # Region của log group
          "awslogs-stream-prefix" = "ecs"            # Prefix cho log stream name
        }
      }
    }
  ])
}

# ECS cluster
resource "aws_ecs_cluster" "main" {
  name = "hotel-app-cluster"

  tags = {
    Name = "hotel-app-cluster"
  }
}

# ECS service
resource "aws_ecs_service" "main" {
  name            = "hotel-app"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.arn # task definition ARN 

  desired_count = 4 # ECS cố gắng duy trì 4 task chạy

  launch_type = "FARGATE" # Chạy container trên hạ tầng Fargate do AWS quản lý

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [var.security_group_id]
    assign_public_ip = false # Task nằm trong private subnet
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "hotel-app"
    container_port   = 5000
  }
}