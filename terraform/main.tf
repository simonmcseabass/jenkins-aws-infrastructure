# Configure Terraform
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
# Configure AWS Provider
provider "aws" {
  region = var.aws_region
}
# Create S3 Bucket
resource "aws_s3_bucket" "app_bucket" {
  bucket = "${var.project_name}-bucket-${var.environment}"
  tags = {
    Name        = "${var.project_name}-bucket"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = var.project_name
  }
}
# Enable versioning on S3 bucket
resource "aws_s3_bucket_versioning" "app_bucket_versioning" {
  bucket = aws_s3_bucket.app_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
# Create Security Group for EC2
resource "aws_security_group" "app_sg" {
  name        = "${var.project_name}-sg-${var.environment}"
  description = "Security group for ${var.project_name} EC2 instance"
  # Allow SSH from anywhere
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Allow HTTP
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "${var.project_name}-sg"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
# Create EC2 Instance
resource "aws_instance" "app_server" {
  ami                    = var.ec2_ami
  instance_type          = var.ec2_instance_type
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  tags = {
    Name        = "${var.project_name}-server"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}