variable "vpc_id" {
  type        = string
  description = "VPC ID from the networking module"
}

variable "security_group_id" {
  description = "Security group IDs for ALB"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for ALB"
  type        = list(string)
}