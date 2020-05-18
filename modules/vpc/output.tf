output "vpc_default_id" {
  value = aws_vpc.defaulttest_vpc.id
}

output "vpc_subnet_id" {
  value = aws_subnet.defaulttest_subnet.id
}
