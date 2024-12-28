terraform {
  backend "s3" {
    bucket         = "kubernetes-gitops-demo-terraform-state-dev" # Ensure this bucket exists
    key            = "terraform/state.tfstate"
    region         = "us-west-2" # Adjust if using a different region
  }
}

provider "aws" {
  region = var.region
}

# VPC Configuration
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "demo-vpc"
  }
}

# Subnet 1
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet1_cidr
  availability_zone = "us-west-2a"
  tags = {
    Name = "demo-subnet1"
  }
}

# Subnet 2
resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet2_cidr
  availability_zone = "us-west-2b"
  tags = {
    Name = "demo-subnet2"
  }
}

# Example EC2 Instance
resource "aws_instance" "example" {
  ami           = "ami-12345678" # Replace with a valid AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet1.id
  tags = {
    Name = "demo-instance"
  }
}

# S3 Bucket
resource "aws_s3_bucket" "example" {
  bucket = "demo-bucket-name"
  tags = {
    Name = "demo-bucket"
  }
}

resource "aws_s3_bucket_acl" "example_acl" {
  bucket = aws_s3_bucket.example.id
  acl    = "private"
}

# Security Group
resource "aws_security_group" "example" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "demo-security-group"
  }
}

# DynamoDB Table for State Locking (optional)
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-state-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "terraform-state-locks"
  }
}
