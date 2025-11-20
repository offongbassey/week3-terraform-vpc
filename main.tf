provider "aws" {
    region = "eu-west-1"
}

resource "aws-vpc" "main-vpc" {
  cidr_block = "10.0.0.0/16"

  tag = {
    name = "Week3-VPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = 10.0.0.0/24
  availability_zone = "eu-west-1a"

  tag = {
    name = "Public-Subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = 10.0.1.0/24
  availability_zone = "eu-west-1b"

  tags = {
    name = "Private-Subnet"
  }
}

resource "aws_internat_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    name = "Main-Internet-Gateway"
  }
}

resource "aws_eip" "nat_eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  ubnet_id      = aws_subnet.public_subnet.id

  tags = {
    name = "Nat-Gateway"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    name = "Public-Route-Table" 
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "Private-Route-Table"
  }
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_web_security_group" "web_sg" {
  vpc_id = aws_vpc.main_vpc.id
  name = "web_security_group"
  description = "Allow SSH and HTTP traffic"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web-SG"
  }
}

resource "aws_instance" "public_ec2" {
  ami           = "ami-049442a6cf8319180" # Example Ubuntu AMI for eu-west-1
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_subnet.id
  security_groups = aws_security_group.web_sg.id

  tags = {
    name = "Public-EC2"
  }
}

resource "aws_instance" "private_ec2" {
  ami           = "ami-049442a6cf8319180" # Same Ubuntu AMI
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.private_subnet.id
  security_groups = [aws_security_group.web_sg.id]

  tags = {
    Name = "Private-EC2"
  }
}
