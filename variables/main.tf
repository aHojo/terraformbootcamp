terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.40.0"
    }
  }
}



provider "aws" {
  region     = var.aws_region
  secret_key = "2giKWF9Abpxn7ReJuUYknEKA8jb39Yj5N60WdaQY"
  access_key = "AKIAQEIR4EKO5HARQPPL"

}


resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "Production VPC"
  }

  enable_dns_support = var.enable_dns
}

resource "aws_subnet" "web" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = var.azs[0]
  tags = {
    "Name" = "Web Subnet"
  }
}

resource "aws_internet_gateway" "my_web_igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    "Name" = "Web Internet Gateway"
  }
}

resource "aws_default_route_table" "main_vpc_default_rt" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_web_igw.id
  }
  tags = {
    "Name" = "my-default-rt"
  }
}

resource "aws_default_security_group" "default_sec_group" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # cidr_blocks = [var.my_public_ip]
  }
  ingress {
    from_port   = var.web_port
    to_port     = var.web_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # cidr_blocks = [var.my_public_ip]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # cidr_blocks = [var.my_public_ip]
  }
  # Below allow everything
  egress {
    from_port   = var.egress_dsg["from_port"]
    to_port     = var.egress_dsg["to_port"]
    protocol    = var.egress_dsg["protocol"]
    cidr_blocks = var.egress_dsg["cidr_block"]
  }
  tags = {
    "Name" = "Default security group"
  }
}

resource "aws_instance" "my_vm" {
  ami                         = var.amis[var.aws_region]
  instance_type               = var.my_instance[0] # tuple 
  cpu_core_count              = var.my_instance[1]
  subnet_id                   = aws_subnet.web.id
  vpc_security_group_ids      = [aws_default_security_group.default_sec_group.id]
  associate_public_ip_address = var.my_instance[2]

  # user_data = <<EOF
  # #!/bin/bash
  # sudo yum -y update && sudo yum -y install httpd
  # sudo systemctl start httpd && sudo systemctl enable httpd
  # sudo echo <h1>Deployed via Terraform</h1> > /var/www/html/index.html
  # EOF
  # user_data = file("entry-script.sh")
  tags = {
    "Name" = "My EC2"
  }
}
