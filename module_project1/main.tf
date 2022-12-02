terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# 0. Configure the AWS Provider
provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# import our child module
module "my_ec2" {
  source = "../modules/ec2" # path to the child module
  # arguements
  ami_id        = var.ami_id
  instance_type = var.instance_type
  count         = var.servers

}
