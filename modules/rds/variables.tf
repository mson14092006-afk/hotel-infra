variable "private_subnet_ids" {
  description = "Private subnet IDs for RDS"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for RDS"
  type        = string
}

variable "db_name" {
  description = "Database name for RDS"
  type        = string
}

variable "db_username" {
  description = "Database username for RDS"
  type        = string
}
variable "db_password" {
  description = "Database password for RDS"
  type        = string
  sensitive   = true
}

variable "environment" {
  type = string
}

variable "db_multi_az" {
  type        = bool
}

variable "db_availability_zone" {
  type        = string
}