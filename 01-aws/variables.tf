variable "vpc_cidr_block" {
  default     = "10.0.0.0/16"
  description = "Default cidr block for the vpc"
  type        = string
}
variable "web_subnet" {
  default     = "10.0.10.0/24"
  description = "Web Subnet"
  type        = string
}

variable "subnet_zone" {

}

variable "vpc_main_name" {

}

variable "my_public_ip" {

}

variable "ssh_public_key" {

}
