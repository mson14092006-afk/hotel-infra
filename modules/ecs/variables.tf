variable "ecr_repository_url" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "environment" {
  type = string
}

variable "ecs_desired_count" {
  type        = number
  description = "Number of ECS tasks to run"
}