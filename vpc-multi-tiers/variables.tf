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

variable "domain_name" {
  type        = string
  description = "Domain name of the public host zone"
}

variable "internal_domain_name" {
  type        = string
  description = "Domain name of the private host zone"
}

variable "cidr_block" {
  type        = string
  description = "CIDR block for the VPC. Consider using a different network space for each VPC. ie. 10.1.0.0/16, 10.1.0.0/16"
}

variable "availability_zones" {
  type        = list
  description = "VPC list of AZ. example: us-east-1a"
}

variable "cert_enabled" {
  type        = string
  default     = true
}

variable "process_domain_validation_options" {
  type        = string
  default     = true
  description = "Validate automatically the certificate. Useful if domain is hosted in AWS"
}
