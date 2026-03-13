resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = "Main VPC"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr_blocks[0]
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet 1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr_blocks[1]
  availability_zone       = var.availability_zones[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet 2"
  }
}

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Main Internet Gateway"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Public route table"
  }
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0" # any ip addresss
  gateway_id             = aws_internet_gateway.main_igw.id
}

resource "aws_route_table_association" "public_route_table_assoc_1" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet_1.id
}

resource "aws_route_table_association" "public_route_table_assoc_2" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet_2.id
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr_blocks[0]
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "Private Subnet 1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr_blocks[1]
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "Private Subnet 2"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "VPC NAT EIP"
  }
}

resource "aws_nat_gateway" "nat_eip" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet_1.id
  tags = {
    Name = "Nat Gateway"
  }

  depends_on = [aws_internet_gateway.main_igw]
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Private Route Table"
  }
}

resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_eip.id
}

resource "aws_route_table_association" "private_route_table_assoc_1" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = aws_subnet.private_subnet_1.id
}

resource "aws_route_table_association" "private_route_table_assoc_2" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = aws_subnet.private_subnet_2.id
}


