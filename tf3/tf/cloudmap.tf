#############################################
# Cloud Map Private DNS Namespace
#############################################

resource "aws_service_discovery_private_dns_namespace" "main" {

  name = "service.local"

  description = "Private DNS Namespace for ECS Services"

  vpc = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-namespace"
  }
}

#############################################
# Backend Cloud Map Service
#############################################

resource "aws_service_discovery_service" "backend" {

  name = "backend"

  dns_config {

    namespace_id = aws_service_discovery_private_dns_namespace.main.id

    routing_policy = "MULTIVALUE"

    dns_records {

      ttl = 10

      type = "A"
    }
  }

  health_check_custom_config {

    failure_threshold = 1
  }
}

#############################################
# Frontend Cloud Map Service
#############################################

resource "aws_service_discovery_service" "frontend" {

  name = "frontend"

  dns_config {

    namespace_id = aws_service_discovery_private_dns_namespace.main.id

    routing_policy = "MULTIVALUE"

    dns_records {

      ttl = 10

      type = "A"
    }
  }

  health_check_custom_config {

    failure_threshold = 1
  }
}