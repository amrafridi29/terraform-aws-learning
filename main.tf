resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "VPC main"
  }
}

# Create a Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet"
  }
}

#  Private Subnet (No public IP)
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.101.0/24"
  availability_zone = "us-east-2b"
  tags = {
    Name = "Private Subnet"
  }
}

# Create the Internet Gateway
resource "aws_internet_gateway" "man_igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Main IGW"
  }
}

# Route Table (The Map)
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Public Route Table"
  }
}

# define route
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.man_igw.id
}

# add routes into the route table
resource "aws_route_table_association" "public_rt_association" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.public_subnet.id
}

# Elastic IP (A permanent public phone number for our NAT)
resource "aws_eip" "nat" {
  domain = "vpc" # Tells AWS this IP is for use inside a VPC
}

# NAT Gateway (The "One-Way Mirror")
resource "aws_nat_gateway" "main_nat" {
  allocation_id = aws_eip.nat.id              # Give it the EIP
  subnet_id     = aws_subnet.public_subnet.id # MUST be in a PUBLIC subnet
  tags = {
    Name = "Main NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.man_igw]

}

# Private route table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Private Route Table"
  }
}

resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main_nat.id
}

resource "aws_route_table_association" "private_rt_association" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.private_subnet.id
}

# 1. VPC Flow Logs (The Security Camera)
resource "aws_flow_log" "vpc_log" {
  log_destination      = aws_s3_bucket.vpc_log_bucket.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.main.id

  tags = {
    Name = "VPC Flow Logs"
  }
}

# S3 bucket to store vpc flow logs
resource "aws_s3_bucket" "vpc_log_bucket" {
  bucket = "vpc-log-bucket-12032026"
}

#  Security Group (The server "Guest List")
resource "aws_security_group" "web_sg" {
  name        = "allow_web"
  description = "Allow HTTP and SSH traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow anyone to see the website
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          # "-1" means ALL protocols
    cidr_blocks = ["0.0.0.0/0"] # Allow the server to talk to the internet
  }

  tags = {
    Name = "Web Security Group"
  }
}

resource "aws_network_acl" "public_nacl" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = [aws_subnet.public_subnet.id] # Applies to every instance in this subnet

  # Rule 100: Allow HTTP Inbound
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  # Rule 200: DENY a specific malicious IP
  ingress {
    protocol   = "tcp"
    rule_no    = 50 # Lower number = higher priority. Evaluated before rule 100.
    action     = "deny"
    cidr_block = "203.0.113.5/32"
    from_port  = 0
    to_port    = 65535
  }

  # IMPORTANT: Stateless Outbound rule
  # Without this, the server can't send the webpage back to the user!
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535 # Ephemeral ports for return traffic
  }

  tags = { Name = "MainSubnetNACL" }
}
