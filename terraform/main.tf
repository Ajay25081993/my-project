provider "aws" {
  region = var.region
}

# Reference the existing security group
data "aws_security_group" "existing_flask" {
  id = "sg-02097d70a68fda810"
}

# Reference the existing EC2 instance
data "aws_instance" "my_ec2" {
  instance_id = "i-03fe9dd428a1f3828"
}
