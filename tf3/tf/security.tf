#############################################
# Security Group for Application Load Balancer
#############################################

resource "aws_security_group" "alb_sg" {

  name        = "${var.project_name}-alb-sg"
  description = "Security Group for ALB"
  vpc_id      = aws_vpc.main.id

  ingress {

    description = "HTTP"

    from_port = 80

    to_port = 80

    protocol = "tcp"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name = "${var.project_name}-alb-sg"
  }
}

#############################################
# Security Group for Frontend ECS Service
#############################################

resource "aws_security_group" "frontend_sg" {

  name        = "${var.project_name}-frontend-sg"
  description = "Security Group for Frontend ECS"
  vpc_id      = aws_vpc.main.id

  ingress {

    description = "Traffic from ALB"

    from_port = var.frontend_container_port

    to_port = var.frontend_container_port

    protocol = "tcp"

    security_groups = [
      aws_security_group.alb_sg.id
    ]
  }

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name = "${var.project_name}-frontend-sg"
  }
}

#############################################
# Security Group for Backend ECS Service
#############################################

resource "aws_security_group" "backend_sg" {

  name        = "${var.project_name}-backend-sg"
  description = "Security Group for Backend ECS"
  vpc_id      = aws_vpc.main.id

  ingress {

    description = "Traffic from Frontend"

    from_port = var.backend_container_port

    to_port = var.backend_container_port

    protocol = "tcp"

    security_groups = [
      aws_security_group.frontend_sg.id
    ]
  }

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name = "${var.project_name}-backend-sg"
  }
}