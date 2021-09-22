
output "pub-id" {
  value       = aws_subnet.public-subnet.id
}

output "pri-id" {
  value       = aws_subnet.private-subnet.id
}