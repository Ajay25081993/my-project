output "ec2_public_ip" {
  description = "Public IP of the existing EC2 instance"
  value       = data.aws_instance.my_ec2.public_ip
}

output "ec2_public_dns" {
  description = "Public DNS of the existing EC2 instance"
  value       = data.aws_instance.my_ec2.public_dns
}
