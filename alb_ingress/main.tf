locals {
  target_group_enabled = "${var.target_group_arn == "" ? "true" : "false"}"
  target_group_arn     = "${local.target_group_enabled == "true" ? join("", aws_lb_target_group.default.*.arn) : var.target_group_arn}"
}

data "aws_lb_target_group" "default" {
  count = length(local.target_group_arn) > 0 ? 1 : 0
  arn =  local.target_group_arn
}

module "default_label" {
  enabled    = local.target_group_enabled
  source     = "git::https://github.com/cloudposse/terraform-terraform-label.git?ref=tags/0.2.1"
  attributes = var.attributes
  delimiter  = var.delimiter
  name       = var.name
  namespace  = var.namespace
  stage      = var.stage
  tags       = var.tags
}

resource "aws_lb_target_group" "default" {
  count       = "${var.enabled && local.target_group_enabled == "true" ? 1 : 0}"
  name        = module.default_label.id
  port        = var.port
  protocol    = var.protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type

  deregistration_delay = var.deregistration_delay

  health_check {
    path                = var.health_check_path
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
    interval            = var.health_check_interval
    matcher             = var.health_check_matcher
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener_rule" "unauthenticated_paths" {
  count        = "${var.enabled && length(var.unauthenticated_paths) > 0 && length(var.unauthenticated_hosts) == 0 ? var.unauthenticated_listener_arns_count : 0}"
  listener_arn = "${var.unauthenticated_listener_arns[count.index]}"
  priority     = "${var.unauthenticated_priority + count.index}"

  action {
      type             = "forward"
      target_group_arn = local.target_group_arn
  }

  condition {
    field  = "path-pattern"
    values = var.unauthenticated_paths
  }
}


resource "aws_lb_listener_rule" "unauthenticated_hosts" {
  count        = "${var.enabled && length(var.unauthenticated_hosts) > 0 && length(var.unauthenticated_paths) == 0 ? var.unauthenticated_listener_arns_count : 0}"
  listener_arn = "${var.unauthenticated_listener_arns[count.index]}"
  priority     = "${var.unauthenticated_priority + count.index}"

  action {
      type             = "forward"
      target_group_arn = local.target_group_arn
  }

  condition {
    field  = "host-header"
    values = "${var.unauthenticated_hosts}"
  }
}

resource "aws_lb_listener_rule" "unauthenticated_hosts_paths" {
  count        = "${var.enabled && length(var.unauthenticated_paths) > 0 && length(var.unauthenticated_hosts) > 0 ? var.unauthenticated_listener_arns_count : 0}"
  listener_arn = "${var.unauthenticated_listener_arns[count.index]}"
  priority     = "${var.unauthenticated_priority + count.index}"

  action {
      type             = "forward"
      target_group_arn = local.target_group_arn
  }

  condition {
    field  = "host-header"
    values = "${var.unauthenticated_hosts}"
  }

  condition {
    field  = "path-pattern"
    values = "${var.unauthenticated_paths}"
  }
}
