variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-2"
}

variable "vpc_id" {
  description = "VPC ID where EC2 will be launched"
  type        = string
  default     = "vpc-043d4183f1937ec18"
}
