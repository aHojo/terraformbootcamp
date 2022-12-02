variable "web_port" {
  description = "Web Port" # String
  default     = 80         # Number
  type        = number     # forces this to be a number
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "enable_dns" {
  description = "DNS Support for the VPC"
  type        = bool
  default     = true

}

variable "azs" {
  description = "AZs in the Region"
  type        = list(string)
  default = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
    "us-east-1d",
    "us-east-1f",
    "us-east-1e"
  ]
}

# type map
variable "amis" {
  type        = map(string)
  description = "values for amis to use"
  default = {
    "us-east-1" = "ami-0b0dcb5067f052a63",
    "us-west-1" = "ami-0f5e8a042c8bfcd5e"

  }

}

# tuple
variable "my_instance" {
  type = tuple([string, number, bool])
  default = [
    "t2.micro",
    1,
    true
  ] # order matters
}

variable "egress_dsg" {
  type = object({
    from_port  = number
    to_port    = number
    protocol   = string
    cidr_block = list(string)
  })
  default = {
    from_port  = 0
    protocol   = "tcp"
    to_port    = 65365
    cidr_block = ["100.0.0.0/16", "200.0.0.0/16"]
  }

}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type = string 
  
}
variable "aws_access_key" {
  description = "AWS Access Key"
  type = string 

}