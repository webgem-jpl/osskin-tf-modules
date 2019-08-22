output "target_group_name" {
  description = "ALB Target group name"
  value       = length(data.aws_lb_target_group.default) > 0 ? data.aws_lb_target_group.default.*.name[0] : ""
}

output "target_group_arn" {
  description = "ALB Target group ARN"
  value       = length(data.aws_lb_target_group.default) > 0 ? data.aws_lb_target_group.default.*.arn[0] : ""
}

output "target_group_arn_suffix" {
  description = "ALB Target group ARN suffix"
  value       = length(data.aws_lb_target_group.default) > 0 ? data.aws_lb_target_group.default.*.arn_suffix[0] : ""
}
