output "public_instance_ip" {
  description = "The public IP address of the EC2 instance in the public subnet"
  value       = aws_instance.public_ec2.public_ip
}

output "private_instance_id" {
  description = "The ID of the EC2 instance in the private subnet"
  value       = aws_instance.private_ec2.id
}
