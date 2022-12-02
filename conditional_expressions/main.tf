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
  secret_key = var.aws_secret_key
  access_key = var.aws_access_key

}


resource "aws_instance" "test_instance" {
  ami           = "ami-0b0dcb5067f052a63"
  instance_type = "t2.micro"
  count         = var.istest == true ? 1 : 0

}
resource "aws_instance" "prod_instance" {
  ami           = "ami-0b0dcb5067f052a63"
  instance_type = "t2.large"
  # count         = 0 # not created when 0
  count = var.istest == true ? 0 : 1

}
