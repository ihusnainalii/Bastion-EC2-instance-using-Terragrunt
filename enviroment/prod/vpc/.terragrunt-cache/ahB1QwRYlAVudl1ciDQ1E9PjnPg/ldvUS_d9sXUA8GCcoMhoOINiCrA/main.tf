# VPC Setup
resource "aws_vpc" "this" {
  cidr_block = var.cidr_block

  tags = {
    Name    = "${var.enviroment}-vpc-main"
    Project = "terraform_practice"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name    = "internet_gateway_${var.enviroment}"
    Project = "terraform_practice"
  }
}

# Subnet Setup
resource "aws_subnet" "subnet_a" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.subnet_a_cidr
  availability_zone = "us-east-1a"

  tags = {
    Name    = "subnet_a_${var.enviroment}"
    Project = "terraform_practice"
  }
}

# Subnet Setup
resource "aws_subnet" "subnet_b" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.subnet_b_cidr
  availability_zone = "us-east-1a"

  tags = {
    Name    = "subnet_b_${var.enviroment}"
    Project = "terraform_practice"
  }
}

# Route Table for Public Subnet
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name    = "public_route_table_${var.enviroment}"
    Project = "terraform_practice"
  }
}

# Associate Route Table with Public Subnet
resource "aws_route_table_association" "public_subnet_assoc" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.public_rt.id
}

# Security Group for EC2 Instance
resource "aws_security_group" "web_ssh_access" {
  vpc_id      = aws_vpc.this.id
  description = "Allow web + ssh traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.security_group_ingress_cidr_block]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.security_group_ingress_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "allow_ssh"
    Project = "terraform_practice"
  }
}