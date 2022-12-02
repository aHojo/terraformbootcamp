variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  default     = "192.168.0.0/16"
  type        = string
}

variable "web_subnet" {
  description = "Subnet for web apps"
  type        = string
  default     = "192.168.100.0/24"

}

variable "server_type" {
  default = "t2.micro"

}
variable "subnet_zone" {
  type    = string
  default = "us-west-1a"
}

variable "main_vpc_name" {
  type    = string
  default = "Main VPC"
}

variable "region" {
  type    = string
  default = "us-west-1"
}

variable "ami" {
  type = map(string)
  default = {
    "us-west-1"    = "ami-02d03ce209db75523"
    "us-west-2"    = "ami-066333d9c572b0680"
    "eu-central-1" = "ami-05cafdf7c9f772ad2"
    "eu-west-1"    = "ami-01efa4023f0f3a042"
  }
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string

}
variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string

}


variable "public_key" {
  default = "./entry-script.sh"

}

variable "script_name" {

  default = "./test_rsa.pub"
}
