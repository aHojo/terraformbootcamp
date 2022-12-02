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
  secret_key = ""
  access_key = ""

}

# resource "aws_instance" "server" {
#   ami           = "ami-05723c3b9cf4bf4ff"
#   instance_type = "t2.micro"
#   count         = 3 # create 3 different instances. 
# }

variable "users" {
  type    = list(string)
  default = ["demo-user", "admin1", "john"]

}
# resource "aws_iam_user" "test" {
#   name  = element(var.users, count.index)
#   path  = "/system/"
#   count = length(var.users)
# }
resource "aws_iam_user" "test" {
  for_each = toset(var.users)
  name     = each.key
}
