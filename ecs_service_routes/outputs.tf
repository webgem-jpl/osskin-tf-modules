output "public_alb_target_group_name" {
  description = "ALB Target group name"
  value       = module.public_alb_ingress.target_group_name
}

output "public_alb_target_group_arn" {
  description = "ALB Target group ARN"
  value       = module.public_alb_ingress.target_group_arn
}

output "public_alb_target_arn_suffix" {
  description = "ALB Target group ARN suffix"
  value       = module.public_alb_ingress.target_group_arn_suffix
}

output "private_alb_target_group_name" {
  description = "ALB Target group name"
  value       = module.private_alb_ingress.target_group_name
}

output "private_alb_target_group_arn" {
  description = "ALB Target group ARN"
  value       = module.private_alb_ingress.target_group_arn
}

output "private_alb_target_arn_suffix" {
  description = "ALB Target group ARN suffix"
  value       = module.private_alb_ingress.target_group_arn_suffix
}
