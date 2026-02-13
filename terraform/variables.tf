variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}
variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "jenkins-demo"
}
variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}
variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro" # Free tier eligible
}
variable "ec2_ami" {
  description = "AMI ID for EC2 instance (Amazon Linux 2023)"
  type        = string
  default     = "ami-0c02fb55b34e7fc8e" # us-east-1
}