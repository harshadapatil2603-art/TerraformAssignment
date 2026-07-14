#############################################
# Application Load Balancer
#############################################

resource "aws_lb" "frontend" {

  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb_sg.id
  ]

  subnets = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]

  enable_deletion_protection = false

  tags = {
    Name = "${var.project_name}-alb"
  }
}

#############################################
# Target Group
#############################################

resource "aws_lb_target_group" "frontend" {

  name        = "${var.project_name}-tg"
  port        = var.frontend_container_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.main.id

  health_check {

    enabled             = true
    protocol            = "HTTP"
    path                = "/"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.project_name}-tg"
  }
}

#############################################
# HTTP Listener
#############################################

resource "aws_lb_listener" "http" {

  load_balancer_arn = aws_lb.frontend.arn

  port     = 80
  protocol = "HTTP"

  default_action {

    type = "forward"

    target_group_arn = aws_lb_target_group.frontend.arn
  }
}