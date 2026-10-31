# Public Subnet
resource "aws_subnet" "public" {

  for_each = var.public_subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "${var.environment}-public-subnet"
  }
}

# Private app subnet
resource "aws_subnet" "private_app" {

  for_each = var.private_app_subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "${var.environment}-private-app-subnet"
  }
}

# Private DB subnet
resource "aws_subnet" "private_db" {

  for_each = var.private_db_subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "${var.environment}-private-db-subnet"
  }
}