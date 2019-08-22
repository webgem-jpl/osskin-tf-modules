# VPC

output "igw_id" {
  value       = module.vpc.igw_id
  description = "The ID of the VPC Internet Gateway"
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the VPC"
}

output "vpc_cidr_block" {
  value       = module.vpc.vpc_cidr_block
  description = "The CIDR block of the VPC"
}

output "vpc_main_route_table_id" {
  value       = module.vpc.vpc_main_route_table_id
  description = "The ID of the main route table associated with this VPC"
}

output "vpc_default_network_acl_id" {
  value       = module.vpc.vpc_default_network_acl_id
  description = "The ID of the network ACL created by default on VPC creation"
}

output "vpc_default_security_group_id" {
  value       = module.vpc.vpc_default_security_group_id
  description = "The ID of the security group created by default on VPC creation"
}

output "vpc_default_route_table_id" {
  value       = module.vpc.vpc_default_route_table_id
  description = "The ID of the route table created by default on VPC creation"
}

output "vpc_ipv6_association_id" {
  value       = module.vpc.vpc_ipv6_association_id
  description = "The association ID for the IPv6 CIDR block"
}

output "ipv6_cidr_block" {
  value       = module.vpc.ipv6_cidr_block
  description = "The IPv6 CIDR block"
}

# Hosted Zones

output "public_zone_id" {
  value = data.aws_route53_zone.public.zone_id
}

output "public_zone_name" {
  value = data.aws_route53_zone.public.name
}

output "private_zone_id" {
  value = aws_route53_zone.private.zone_id
}

output "private_zone_name" {
  value = aws_route53_zone.private.name
}

# Subnets
output "public_subnet_ids" {
  description = "IDs of the created public subnets"
  value       = module.subnets.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the created private subnets"
  value       = module.subnets.private_subnet_ids
}

output "public_subnet_cidrs" {
  description = "CIDR blocks of the created public subnets"
  value       = module.subnets.public_subnet_cidrs
}

output "private_subnet_cidrs" {
  description = "CIDR blocks of the created private subnets"
  value       = module.subnets.private_subnet_cidrs
}

output "public_route_table_ids" {
  description = "IDs of the created public route tables"
  value       = module.subnets.public_route_table_ids
}

output "private_route_table_ids" {
  description = "IDs of the created private route tables"
  value       = module.subnets.private_route_table_ids
}

output "nat_gateway_ids" {
  description = "IDs of the NAT Gateways created"
  value       = module.subnets.nat_gateway_ids
}

output "nat_instance_ids" {
  description = "IDs of the NAT Instances created"
  value       = module.subnets.nat_instance_ids
}

output "availability_zones" {
  description = "List of Availability Zones where subnets were created"
  value       = module.subnets.availability_zones
}

# Public ALB
output "public_alb_name" {
  description = "The ARN suffix of the ALB"
  value       = module.public_alb.alb_name
}

output "public_alb_arn" {
  description = "The ARN of the ALB"
  value       = module.public_alb.alb_arn
}

output "public_alb_http_listener_arn" {
 value        = module.public_alb.http_listener_arn
}

output "public_alb_https_listener_arn" {
 value        = module.public_alb.https_listener_arn
}

output "public_alb_dns_name" {
  description = "DNS name of ALB"
  value       = "${module.public_alb.alb_dns_name}"
}

output "public_security_group_id" {
  description = "The security group ID of the public subnet"
  value       = "${module.public_alb.security_group_id}"
}

# Private ALB
output "private_alb_name" {
  description = "The ARN suffix of the ALB"
  value       = module.private_alb.alb_name
}

output "private_alb_arn" {
  description = "The ARN of the ALB"
  value       = module.private_alb.alb_arn
}

output "private_alb_http_listener_arn" {
 value        = module.private_alb.http_listener_arn
}

output "private_alb_dns_name" {
  description = "DNS name of ALB"
  value       = "${module.private_alb.alb_dns_name}"
}

output "private_security_group_id" {
  description = "The security group ID of the private subnet"
  value       = "${module.private_alb.security_group_id}"
}

# Certificate
output "acm_certificate_id" {
  value       = module.acm_request_certificate.id
  description = "The ID of the certificate"
}

output "acm_certificate_arn" {
  value       = module.acm_request_certificate.arn
  description = "The ARN of the certificate"
}

output "acm_certificate_domain_validation_options" {
  value       = module.acm_request_certificate.domain_validation_options
  description = "CNAME records that are added to the DNS zone to complete certificate validation"
}

# Cluster
output "ecs_cluster_id" {
  value       = aws_ecs_cluster.default.id
}
output "ecs_cluster_name" {
  value       = aws_ecs_cluster.default.name
}
output "ecs_cluster_arn" {
  value       = aws_ecs_cluster.default.arn
}

output "allow_public_alb_sg_id" {
  value       = aws_security_group.public_subnet.id
}

output "allow_private_alb_sg_id" {
  value       = aws_security_group.private_subnet.id
}
