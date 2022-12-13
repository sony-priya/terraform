#whenever a vpc is created a default route table is created but we create our own route table

resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    name = "Myroute"
  }
}


//associating subnets to route table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.rtb.id
  count          = 2
}

//adding nat gateway to route table
resource "aws_default_route_table" "natgw" {
	default_route_table_id = aws_vpc.main.default_route_table_id
	route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw.id
  }
  tags = {
    Name = "fltrb"
  }
}