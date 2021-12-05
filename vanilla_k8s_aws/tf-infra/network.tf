
#VPC
resource "aws_vpc" "test-vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = "my-${terraform.workspace}-workspace-vpc"
  }
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
}

#Internet Gateway 
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.test-vpc.id
  tags = {
    Name = "Test - ${terraform.workspace}"
  }
}

#Security Group for VPC

resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow Web inbound traffic"
  vpc_id      = aws_vpc.test-vpc.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_web_and_ssh"
  }
}


#For high availability
data "aws_availability_zones" "available" {
  filter {
    name   = "state"
    values = ["available"]
  }
}

#Subnet
resource "aws_subnet" "test-subnet" {
  vpc_id = aws_vpc.test-vpc.id
  cidr_block        = cidrsubnet(var.cidr_block, 4, var.az_number[substr(each.key, -1, 0)])
  for_each          = toset(data.aws_availability_zones.available.names)
  availability_zone = each.key

  map_public_ip_on_launch = true
  tags = {
    "Name" = "Test - ${terraform.workspace} - ${index(data.aws_availability_zones.available.names, each.value) + 1}"
  }
}


#Route Table
resource "aws_route_table" "test-route-table" {
  vpc_id = aws_vpc.test-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Test - ${terraform.workspace}"
  }

}

#Attaching route table to subnet
resource "aws_route_table_association" "associate_route_and_subnet" {
  for_each       = aws_subnet.test-subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.test-route-table.id
}