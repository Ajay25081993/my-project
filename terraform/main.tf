provider "aws" {
  region = var.region
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-0f684d40c1e7eee5c" # ✅ Valid Ubuntu AMI in ap-south-2
  instance_type = "t3.micro"              # ✅ Free Tier eligible in ap-south-2
}
