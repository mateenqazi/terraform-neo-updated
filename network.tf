data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "MainVPC-${var.environment}"
  }
}

resource "aws_subnet" "main_subnet" {
  count             = 2
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = cidrsubnet("10.0.0.0/16", 8, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name = "MainSubnet-${var.environment}-${count.index}"
  }
}

resource "aws_internet_gateway" "main_gateway" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "MainInternetGateway-${var.environment}"
  }
}

resource "aws_route_table" "main_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_gateway.id
  }
  tags = {
    Name = "MainRouteTable-${var.environment}"
  }
}

resource "aws_route_table_association" "main_route_association" {
  count          = length(aws_subnet.main_subnet)
  subnet_id      = aws_subnet.main_subnet[count.index].id
  route_table_id = aws_route_table.main_route_table.id
}

resource "aws_security_group" "main_sg" {
  name        = "MainSecurityGroup-${var.environment}"
  description = "Security group for all instances in VPC"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "main_db_subnet_group" {
  name       = "main-db-subnet-group-${var.environment}"
  subnet_ids = aws_subnet.main_subnet[*].id
}
