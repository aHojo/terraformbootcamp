terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.40.0"
    }
  }
}



provider "aws" {
  region     = "us-east-1"
  secret_key = "2giKWF9Abpxn7ReJuUYknEKA8jb39Yj5N60WdaQY"
  access_key = "AKIAQEIR4EKO5HARQPPL"

}

# resource "<provider>_<resource_type>" "<local_name>" {
#   .... config options
# } 

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    "Name" = "Main VPC"
  }
}

# create a subnet
resource "aws_subnet" "web" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.web_subnet
  availability_zone = var.subnet_zone
  tags = {
    "Name" = "Web Subnet"
  }
}

resource "aws_internet_gateway" "my_web_igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    "Name" = "${var.vpc_main_name} IGW"
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
    from_port   = 80
    to_port     = 80
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
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "Default security group"
  }
}

resource "aws_key_pair" "test_ssh_key" {
  key_name   = "testing_ssh_key"
  public_key = file(var.ssh_public_key)
}

data "aws_ami" "latest_amazon_linux2" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-x86_64-gp2"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

}

resource "aws_instance" "my_vm" {
  ami                         = data.aws_ami.latest_amazon_linux2.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.web.id
  vpc_security_group_ids      = [aws_default_security_group.default_sec_group.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.test_ssh_key.key_name

  # user_data = <<EOF
  # #!/bin/bash
  # sudo yum -y update && sudo yum -y install httpd
  # sudo systemctl start httpd && sudo systemctl enable httpd
  # sudo echo <h1>Deployed via Terraform</h1> > /var/www/html/index.html
  # EOF
  user_data = file("entry-script.sh")
  tags = {
    "Name" = "My EC2"
  }
}
