variable "public_key" {

}

variable "server_type" {
  default = "t2.micro"

}

variable "script_name" {

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

variable "vpc_id" {

}

variable "subnet_id" {

}
