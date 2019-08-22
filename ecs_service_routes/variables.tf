variable "region" {
  type        = string
  description = "Region where to deploy infrastructure"
}

variable "namespace" {
  type        = string
  description = "namespace of infrastructure"
}

variable "stage" {
  type        = string
  description = "stage or environment of infrastructure"
}

variable "name" {
  type        = string
  description = "namespace of infrastructure"
}

variable "domain_name" {
  type        = string
  default     = ""
  description = "Domain name of the public host zone"
}

variable "internal_domain_name" {
  type        = string
  description = "Domain name of the private host zone"
}

variable "vpc_id" {
  type        = string
}

variable "public_alb_dns_name" {
  type        = string
}

variable "private_alb_dns_name" {
  type        = string
}

variable "public_alb_listener_arns" {
  type        = list
  default     = []
  description = "A list of unauthenticated ALB listener ARNs to attach ALB listener rules to"
}

variable "public_alb_listener_arns_count" {
  type        = string
  default     = 0
  description = "The number of unauthenticated ARNs in `alb_ingress_unauthenticated_listener_arns`. This is necessary to work around a limitation in Terraform where counts cannot be computed"
}

variable "private_alb_listener_arns" {
  type        = list
  default     = []
  description = "A list of unauthenticated ALB listener ARNs to attach ALB listener rules to"
}

variable "private_alb_listener_arns_count" {
  type        = string
  default     = 0
  description = "The number of unauthenticated ARNs in `alb_ingress_unauthenticated_listener_arns`. This is necessary to work around a limitation in Terraform where counts cannot be computed"
}

variable "alb_ingress_healthcheck_path" {
  type        = string
}

variable "alb_ingress_paths" {
  type        = list
}

variable "container_port" {
  type        = "string"
  description = "The port number on the container bound to assigned host_port"
  default     = "80"
}

variable "enabled" {
  type        = string
  default     = true
}

variable "alb_ingress_listener_priority" {
  type        = "string"
  default     = "1000"
  description = "The priority for the rules without authentication, between 1 and 50000 (1 being highest priority). Must be different from `alb_ingress_listener_authenticated_priority` since a listener can't have multiple rules with the same priority"
}
