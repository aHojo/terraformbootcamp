output "ec2_public_ip" {
  description = "The public ip address of the ec2 instance" # Optional
  value       = aws_instance.my_vm.public_ip
}

output "vpc_id" {
  description = "ID of VPC"
  value       = aws_vpc.main.id
}

output "ami_id" {
  description = "ID of AMI"
  value       = aws_instance.my_vm.ami
  sensitive   = true # default is false

}
