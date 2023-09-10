
# allocate elastic ip for the nat-gateway in the public subnet 1 (PUB_SUB1)
resource "aws_eip" "EIP-NAT-GW1" {
  vpc = true

  tags = {
    Name = "NAT-GW-EIP1"
  }
}



# allocate elastic ip for the nat-gateway in the public subnet 2 (PUB_SUB2)
resource "aws_eip" "EIP-NAT-GW2" {
  vpc = true

  tags = {
    Name = "NAT-GW-EIP2"
  }
}

resource "aws_nat_gateway" "nat_gw1" {
  allocation_id = aws_eip.EIP-NAT-GW1.id
  subnet_id     = var.PUB_SUB1_ID

  tags = {
    Name = "nat_gw1"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [var.IGW_ID]
}

resource "aws_nat_gateway" "nat_gw2" {
  allocation_id = aws_eip.EIP-NAT-GW2.id
  subnet_id     = var.PUB_SUB2_ID

  tags = {
    Name = "nat_gw2"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [var.IGW_ID]
}

# create private route table pri-rt-a and add route through nat_gw1
resource "aws_route_table" "pri-rt-a" {
  vpc_id = var.VPC_ID

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw1.id
  }

  tags = {
    Name = "pri-rt-a"
  }
}

# associate private subnet pri-sub3 with private route table pri-rt-a
resource "aws_route_table_association" "pri-sub3-with-pri-rt-a" {
  subnet_id      = var.PRI_SUB3_ID
  route_table_id = aws_route_table.pri-rt-a.id
}


# create private route table pri-rt-b and add route through nat_gw2
resource "aws_route_table" "pri-rt-b" {
  vpc_id = var.VPC_ID

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw2.id
  }

  tags = {
    Name = "pri-rt-b"
  }
}

# associate private subnet pri-sub4 with private route pri-rt-b
resource "aws_route_table_association" "pri-sub4-with-pri-rt-b" {
  subnet_id      = var.PRI_SUB4_ID
  route_table_id = aws_route_table.pri-rt-b.id
}