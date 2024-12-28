variable "region" {
  description = "AWS region for resources"
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet1_cidr" {
  description = "CIDR block for Subnet 1"
  default     = "10.0.1.0/24"
}

variable "subnet2_cidr" {
  description = "CIDR block for Subnet 2"
  default     = "10.0.2.0/24"
}
