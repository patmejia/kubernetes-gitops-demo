output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "subnet1_id" {
  description = "The ID of Subnet 1"
  value       = aws_subnet.subnet1.id
}

output "subnet2_id" {
  description = "The ID of Subnet 2"
  value       = aws_subnet.subnet2.id
}
