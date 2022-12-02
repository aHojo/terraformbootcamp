variable "ami_id" {
  description = "ami id to provision"
  type        = string
  default     = "ami-0b0dcb5067f052a63"

}

variable "instance_type" {

  description = "Instance typ"
  type        = string
  default     = "t2.micro"
}

variable "servers" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}
