provider "aws" {
  region = var.region
}

resource "aws_security_group" "allow_flask" {
  name        = "allow_flask"
  description = "Allow Flask app traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Flask app access"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-0f684d40c1e7eee5c"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_flask.id]

  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update -y
    sudo apt-get install -y docker.io awscli
    sudo systemctl start docker
    sudo systemctl enable docker

    REGION="ap-south-2"
    ACCOUNT_ID="206482633930"
    REPO="my-app"
    IMAGE_URI="$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPO:latest"

    aws ecr get-login-password --region $REGION | sudo docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com
    sudo docker pull $IMAGE_URI
    sudo docker run -d -p 5000:5000 $IMAGE_URI
  EOF
}

