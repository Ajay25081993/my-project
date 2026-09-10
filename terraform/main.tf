provider "aws" {
  region = var.region
}

# Reference the existing security group by ID
data "aws_security_group" "existing_flask" {
  id = "sg-02097d70a68fda810"
}

resource "aws_instance" "my_ec2" {
  # Import this existing instance with terraform import
  # terraform import aws_instance.my_ec2 i-03fe9dd428a1f3828
  ami                    = "ami-0f684d40c1e7eee5c"   # keep for documentation, but Terraform will use the imported instance
  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_security_group.existing_flask.id]

  # user_data won't re-run on an imported instance unless you recreate it
  # For existing EC2, you’ll need to SSH in and run Docker manually, or bake it into an AMI
  # So leave user_data commented out here to avoid confusion
  # user_data = <<-EOF
  #   #!/bin/bash
  #   sudo apt-get update -y
  #   sudo apt-get install -y docker.io awscli
  #   sudo systemctl start docker
  #   sudo systemctl enable docker
  #
  #   REGION="ap-south-2"
  #   ACCOUNT_ID="206482633930"
  #   REPO="my-app"
  #   IMAGE_URI="$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPO:latest"
  #
  #   aws ecr get-login-password --region $REGION | sudo docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com
  #   sudo docker pull $IMAGE_URI
  #   sudo docker run -d --restart always -p 5000:5000 $IMAGE_URI
  # EOF
}
