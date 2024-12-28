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

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "demo-vpc"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet1_cidr
  availability_zone = "us-west-2a"
  tags = {
    Name = "demo-subnet1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet2_cidr
  availability_zone = "us-west-2b"
  tags = {
    Name = "demo-subnet2"
  }
}
