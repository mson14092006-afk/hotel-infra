# Public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.environment}-public-route-table"
  }
}

# Private app and db route table
resource "aws_route_table" "private_app" {
  vpc_id = aws_vpc.main.id

  for_each = aws_subnet.private_app

  route {
    cidr_block = "0.0.0.0/0"

    # private_app_a → NAT [0]
    # private_app_b → NAT [1]
    nat_gateway_id = aws_nat_gateway.main[
      each.key == "private_app_a" ? 0 : 1
    ].id
  }

  tags = {
    Name = "${var.environment}-private-app-route-table"
  }
}
resource "aws_route_table" "private_db" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.environment}-private-db-route-table"
  }
}


# Association to route table

resource "aws_route_table_association" "public" {

  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_app" {

  for_each = aws_subnet.private_app

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_app[each.key].id
}

resource "aws_route_table_association" "private_db" {

  for_each = aws_subnet.private_db

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_db.id
}

