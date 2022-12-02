
output "ec2_public_ip" {
  value       = module.server.aws_instance.public_ip
  description = "The public IP of the EC2 instance"
}

output "ami_id" {
  description = "The ID of the AMI"
  value       = module.server.aws_instance.id
  sensitive   = true
}

# output "Datetime" {
#   description = "Current Data and Time"
#   value       = local.time
# }
