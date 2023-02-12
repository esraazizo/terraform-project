resource "aws_lb" "webapp-alb" {
  name               = var.alb-name
  internal           = var.check-internal
  load_balancer_type = var.lb-type
  security_groups    = var.SG-lb
  subnets            = var.subnets-id

  enable_cross_zone_load_balancing = var.checking-cross-zone-lb
  enable_deletion_protection = var.check-deny

  tags = {
    Name = var.name-lb
  }
}

resource "aws_lb_target_group" "target-group" {
   name               = var.grp-name-target
   target_type        = var.grp-type-target
   port               = var.port-of-instances
   protocol           = var.protocol-of-instances
   vpc_id             = var.vpc-id
   health_check {
    healthy_threshold   = var.healthy-threshold-instances
    interval            = var.interval-of-hc
    unhealthy_threshold = var.unhealthy-threshold-instances
    timeout             = var.timeout-instances
    path                = var.path-of-hc
    port                = var.port-of-instances
  }
}

resource "aws_lb_target_group_attachment" "tg_test" {
    count = length(var.instances-id)
    target_group_arn = aws_lb_target_group.target-group.arn
    target_id        = var.instances-id[count.index]
    port             = var.port-of-instances
    depends_on = [
      var.dependencies
    ]
}


resource "aws_lb_listener" "lb_listener_http" {
   load_balancer_arn    = aws_lb.webapp-alb.arn
   port                 = 80
   protocol             = "HTTP"
   default_action {
    target_group_arn = aws_lb_target_group.target-group.arn
    type             = var.lisnter-type
  }
}