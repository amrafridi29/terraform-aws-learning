resource "aws_lb" "alb" {
  name               = "${var.name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnets

  enable_deletion_protection = true

  tags = {
    Name = "${var.name}-alb"
  }
}

resource "aws_lb_target_group" "web" {
  name     = "${var.name}-web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  tags = {
    Name = "${var.name}-web-tg"
  }
}

resource "aws_lb_target_group_attachment" "web_attachments" {
  count            = length(var.web_instance_ids)
  target_group_arn = aws_lb_target_group.web.arn
  target_id        = var.web_instance_ids[count.index]
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }

  tags = {
    Name = "${var.name}-http-listener"
  }
}
