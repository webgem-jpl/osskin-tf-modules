module "vpc" {
  source     = "git::https://github.com/cloudposse/terraform-aws-vpc.git?ref=tags/0.4.2"
  namespace  = var.namespace
  stage      = var.stage
  name       = "vpc"
  cidr_block = var.cidr_block
}

data "aws_route53_zone" "public" {
  name         = "${var.domain_name}."
  private_zone = false
}

resource "aws_route53_zone" "private" {
  name = var.internal_domain_name

  vpc {
    vpc_id = module.vpc.vpc_id
  }
}

module "subnets" {
  source             = "git::https://github.com/cloudposse/terraform-aws-dynamic-subnets.git?ref=tags/0.16.0"
  namespace          = var.namespace
  stage              = var.stage
  availability_zones = var.availability_zones
  vpc_id             = module.vpc.vpc_id
  igw_id             = module.vpc.igw_id
  cidr_block         = var.cidr_block
}

module "acm_request_certificate" {
  source                            = "git::https://github.com/cloudposse/terraform-aws-acm-request-certificate.git?ref=tags/0.4.0"
  enabled                           = var.cert_enabled
  domain_name                       = var.domain_name
  process_domain_validation_options = var.process_domain_validation_options
  ttl                               = "300"
  subject_alternative_names         = ["*.${var.domain_name}","*.${var.stage}.${var.domain_name}"]
}

module "public_alb" {
  source                    = "git::https://github.com/webgem-jpl/osskin-tf-modules/osskin-tf-modules/terraform-aws-vpc.git?ref=tags/0.1.1"
  namespace                 = var.namespace
  stage                     = var.stage
  name                      = "public"
  certificate_arn           = module.acm_request_certificate.arn
  vpc_id                    = module.vpc.vpc_id
  https_enabled             = true
  subnet_ids                = module.subnets.public_subnet_ids
  access_logs_region        = var.region
}

module "private_alb" {
  source                    = "git::https://github.com/webgem-jpl/osskin-tf-modules/osskin-tf-modules/terraform-aws-vpc.git?ref=tags/0.1.1"
  namespace                 = var.namespace
  stage                     = var.stage
  name                      = "private"
  internal                  = true
  vpc_id                    = module.vpc.vpc_id
  https_enabled             = false
  http_ingress_cidr_blocks  = [var.cidr_block]
  subnet_ids                = module.subnets.private_subnet_ids
  access_logs_region        = var.region
}

module "public_alb_label" {
  source     = "git::https://github.com/cloudposse/terraform-terraform-label.git?ref=tags/0.2.1"
  name       = "public-alb"
  attributes = ["allow"]
  namespace  = "${var.namespace}"
  stage      = "${var.stage}"
}

module "private_alb_label" {
  source     = "git::https://github.com/cloudposse/terraform-terraform-label.git?ref=tags/0.2.1"
  name       = "private-alb"
  attributes = ["allow"]
  namespace  = "${var.namespace}"
  stage      = "${var.stage}"
}

resource "aws_security_group" "public_subnet" {
  vpc_id      = module.vpc.vpc_id
  name        = "${module.public_alb_label.id}"
  description = "Allow ECS ports range from public ALB"
  tags        = "${module.public_alb_label.tags}"
}

resource "aws_security_group_rule" "allow_public_alb" {
type                     = "ingress"
from_port                = 0
to_port                  = 65535
protocol                 = "tcp"
source_security_group_id = "${module.public_alb.security_group_id}"
security_group_id        = "${aws_security_group.public_subnet.id}"
}

resource "aws_security_group" "private_subnet" {
  vpc_id      = module.vpc.vpc_id
  name        = "${module.private_alb_label.id}"
  description = "Allow ECS ports range from private ALB"
  tags        = "${module.private_alb_label.tags}"
}

resource "aws_security_group_rule" "allow_private_alb" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = "${module.private_alb.security_group_id}"
  security_group_id        = "${aws_security_group.private_subnet.id}"
}

module "ecs_cluster_label" {
  source     = "git::https://github.com/cloudposse/terraform-terraform-label.git?ref=tags/0.2.1"
  name       = "cluster"
  attributes = ["default"]
  namespace  = "${var.namespace}"
  stage      = "${var.stage}"
}

# ECS Cluster (needed even if using FARGATE launch type)
resource "aws_ecs_cluster" "default" {
  name = "${module.ecs_cluster_label.id}"
}
