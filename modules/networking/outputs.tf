output "vpc_id" {
  value = aws_vpc.main.id
} # Xuất VPC ID cho module khác

output "public_subnet_ids" {
  value = [for subnet in aws_subnet.public : subnet.id]
}

output "private_app_subnet_ids" {
  value = [for subnet in aws_subnet.private_app : subnet.id]
}

output "private_db_subnet_ids" {
  value = [for subnet in aws_subnet.private_db : subnet.id]
}