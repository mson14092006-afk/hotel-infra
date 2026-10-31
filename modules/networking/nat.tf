# Elastic IP
resource "aws_eip" "nat" {
  count = var.environment == "dev" ? 1 : 2 # dev tạo 1, production tạo 2

  domain = "vpc"

  tags = {
    Name = "${var.environment}-nat-eip-${count.index}"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "main" {
  count = var.environment == "dev" ? 1 : 2 # dev tạo 1, production tạo 2

  # NAT số 0 dùng EIP số 0; NAT số 1 dùng EIP số 1
  allocation_id = aws_eip.nat[count.index].id

  # NAT số 0 ở public_a; NAT số 1 ở public_b
  subnet_id = aws_subnet.public[
    count.index == 0 ? "public_a" : "public_b"
  ].id

  tags = {
    Name = "${var.environment}-nat-gateway-${count.index}"
  }

  depends_on = [
    aws_internet_gateway.igw
  ]
}