output "vpc_link_id" {
  description = "ID do VPC Link criado"
  value       = aws_api_gateway_vpc_link.this.id
}

output "nlb_dns_name" {
  description = "DNS do Network Load Balancer"
  value       = aws_lb.nlb.dns_name
}