resource "aws_alb" "app_lb" {
  name               = "app-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups            = var.alb_security_groups
  subnets                    = var.public_subnets
  enable_deletion_protection = false

  tags = {
    name = "Application Alb"
  }
}

resource "aws_lb_target_group" "app_tg" {
  name     = "app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_alb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "instance_attachment" {
  count = length(var.instance_ids)

  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = var.instance_ids[count.index]
  port             = 80
}
