variable "namespace" {
  type        = "string"
  description = "Namespace, which could be your organization name, e.g. `cp` or `cloudposse`"
}

variable "stage" {
  type        = "string"
  description = "Stage, e.g. `prod`, `staging`, `dev`, or `test`"
}

variable "name" {
  type        = "string"
  description = "Solution name, e.g. `app`"
}

variable "delimiter" {
  type        = "string"
  default     = "-"
  description = "Delimiter to be used between `namespace`, `name`, `stage` and `attributes`"
}

variable "attributes" {
  type        = "list"
  default     = []
  description = "Additional attributes, e.g. `1`"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional tags (e.g. `map(`BusinessUnit`,`XYZ`)"
}

variable "target_group_arn" {
  type        = "string"
  default     = ""
  description = "ALB target group ARN. If this is an empty string, a new one will be generated"
}

variable "unauthenticated_listener_arns" {
  type        = "list"
  default     = []
  description = "A list of unauthenticated ALB listener ARNs to attach ALB listener rules to"
}

variable "unauthenticated_listener_arns_count" {
  type        = "string"
  default     = "0"
  description = "The number of unauthenticated ARNs in `unauthenticated_listener_arns`. This is necessary to work around a limitation in Terraform where counts cannot be computed"
}

variable "deregistration_delay" {
  type        = "string"
  default     = "15"
  description = "The amount of time to wait in seconds while deregistering target"
}

variable "health_check_path" {
  type        = "string"
  default     = "/"
  description = "The destination for the health check request"
}

variable "health_check_timeout" {
  type        = "string"
  default     = "10"
  description = "The amount of time to wait in seconds before failing a health check request"
}

variable "health_check_healthy_threshold" {
  type        = "string"
  default     = "2"
  description = "The number of consecutive health checks successes required before healthy"
}

variable "health_check_unhealthy_threshold" {
  type        = "string"
  default     = "2"
  description = "The number of consecutive health check failures required before unhealthy"
}

variable "health_check_interval" {
  type        = "string"
  default     = "15"
  description = "The duration in seconds in between health checks"
}

variable "health_check_matcher" {
  type        = "string"
  default     = "200-399"
  description = "The HTTP response codes to indicate a healthy check"
}

variable "unauthenticated_priority" {
  type        = "string"
  default     = "100"
  description = "The priority for the rules without authentication, between 1 and 50000 (1 being highest priority). Must be different from `authenticated_priority` since a listener can't have multiple rules with the same priority"
}

variable "port" {
  type        = "string"
  default     = "80"
  description = "The port for generated ALB target group (if `target_group_arn` not set)"
}

variable "protocol" {
  type        = "string"
  default     = "HTTP"
  description = "The protocol for generated ALB target group (if `target_group_arn` not set)"
}

variable "target_type" {
  type    = "string"
  default = "ip"
}

variable "vpc_id" {
  type        = "string"
  description = "The VPC ID where generated ALB target group will be provisioned (if `target_group_arn` is not set)"
}

variable "unauthenticated_hosts" {
  type        = "list"
  default     = []
  description = "Unauthenticated hosts to match in Hosts header"
}

variable "unauthenticated_paths" {
  type        = "list"
  default     = []
  description = "Unauthenticated path pattern to match (a maximum of 1 can be defined)"
}

variable "enabled" {
  type        = "string"
  default     = true
  description = "Enabled module"
}
