terraform {
  backend "s3" {
    bucket         = "kubernetes-gitops-demo-terraform-state-dev"
    key            = "terraform/state.tfstate"
    region         = "us-west-2"
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
  ami           = "ami-00b44d3dbe1f81742"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet1.id
  tags = {
    Name = "demo-instance"
  }
}

# S3 Bucket
resource "aws_s3_bucket" "example" {
  bucket = "kubernetes-gitops-demo-unique-bucket-us-west-2"
  tags = {
    Name = "demo-bucket"
  }
}

# S3 Bucket Public Access Block
resource "aws_s3_bucket_public_access_block" "example_public_access" {
  bucket                  = aws_s3_bucket.example.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# S3 Bucket Policy
resource "aws_s3_bucket_policy" "example_policy" {
  bucket = aws_s3_bucket.example.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AllowFullAccessToBucketOwner",
        Effect    = "Allow",
        Principal = "*",
        Action    = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ],
        Resource  = "arn:aws:s3:::kubernetes-gitops-demo-unique-bucket-us-west-2/*"
      }
    ]
  })
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
