output "vpc_id" {
  value       = aws_vpc.main.id
  description = "Id of VPC"
}

output "public_subnet_ids" {
  value       = aws_subnet.public[*].id
  description = "Ids of public subnets"
}

output "private_subnet_ids" {
  value       = aws_subnet.private[*].id
  description = "Ids of private subnets"
}
