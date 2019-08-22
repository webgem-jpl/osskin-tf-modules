data "aws_route53_zone" "public" {
  count = var.domain_name == "" ? 0 : 1
  name         = "${var.domain_name}."
  private_zone = false
}

data "aws_route53_zone" "private" {
  name         = "${var.internal_domain_name}."
  vpc_id       = var.vpc_id
  private_zone = true
}

resource "aws_route53_record" "api" {
  count = var.domain_name == "" ? 0 : 1
  zone_id = data.aws_route53_zone.public[0].zone_id
  name    = "${var.name}.${var.stage}"
  type    = "CNAME"
  ttl     = "900"
  records = [var.public_alb_dns_name]
}

resource "aws_route53_record" "internal_api" {
  zone_id = data.aws_route53_zone.private.zone_id
  name    = "${var.name}.${var.stage}"
  type    = "CNAME"
  ttl     = "900"
  records = [var.private_alb_dns_name]
}

module "private_alb_ingress" {
  source            = "git::https://github.com/webgem-jpl/osskin-tf-modules/osskin-tf-modules/alb_ingress.git?ref=tags/0.1.1"
  enabled           = "${var.private_alb_listener_arns_count == 0 ? false : true}"
  name              = var.name
  namespace         = var.namespace
  stage             = var.stage
  attributes        = ["private"]
  vpc_id            = var.vpc_id
  port              = var.container_port
  health_check_path = var.alb_ingress_healthcheck_path

  unauthenticated_paths = var.alb_ingress_paths
  unauthenticated_hosts = ["${var.name}.${var.stage}.${var.internal_domain_name}"]
  unauthenticated_priority = var.alb_ingress_listener_priority

  unauthenticated_listener_arns       = var.private_alb_listener_arns
  unauthenticated_listener_arns_count = var.private_alb_listener_arns_count
}

module "public_alb_ingress" {
  source            = "git::https://github.com/webgem-jpl/osskin-tf-modules/osskin-tf-modules/alb_ingress.git?ref=tags/0.1.1"
  enabled           = "${var.public_alb_listener_arns_count > 0 ? true : false}"
  name              = var.name
  namespace         = var.namespace
  stage             = var.stage
  attributes        = ["public"]
  vpc_id            = var.vpc_id
  port              = var.container_port
  health_check_path = var.alb_ingress_healthcheck_path

  unauthenticated_paths = var.alb_ingress_paths
  unauthenticated_hosts = ["${var.name}.${var.stage}.${var.domain_name}"]

  unauthenticated_listener_arns       = var.public_alb_listener_arns
  unauthenticated_listener_arns_count = var.public_alb_listener_arns_count
}
