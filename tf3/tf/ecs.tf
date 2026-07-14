#############################################
# ECS CLUSTER
#############################################

resource "aws_ecs_cluster" "main" {

  name = var.ecs_cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = var.ecs_cluster_name
  }
}

#########################################################
# BACKEND TASK DEFINITION
#########################################################

resource "aws_ecs_task_definition" "backend" {

  family = "backend"

  requires_compatibilities = ["FARGATE"]

  network_mode = "awsvpc"

  cpu = var.backend_cpu

  memory = var.backend_memory

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  task_role_arn = aws_iam_role.ecs_task_role.arn

  runtime_platform {

    operating_system_family = "LINUX"

    cpu_architecture = "X86_64"

  }

  container_definitions = jsonencode([

    {

      name = "backend"

      image = "${aws_ecr_repository.backend.repository_url}:latest"

      essential = true

      portMappings = [

        {

          containerPort = 5000

          hostPort = 5000

          protocol = "tcp"

        }

      ]

      environment = [

        {

          name = "MONGO_URI"

          value = var.mongo_uri

        },

        {

          name = "DB_NAME"

          value = var.db_name

        },

        {

          name = "COLLECTION"

          value = var.collection_name

        }

      ]

      logConfiguration = {

        logDriver = "awslogs"

        options = {

          awslogs-group = aws_cloudwatch_log_group.backend.name

          awslogs-region = var.region

          awslogs-stream-prefix = "backend"

        }

      }

    }

  ])

}

#########################################################
# FRONTEND TASK DEFINITION
#########################################################

resource "aws_ecs_task_definition" "frontend" {

  family = "frontend"

  requires_compatibilities = ["FARGATE"]

  network_mode = "awsvpc"

  cpu = var.frontend_cpu

  memory = var.frontend_memory

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  task_role_arn = aws_iam_role.ecs_task_role.arn

  runtime_platform {

    operating_system_family = "LINUX"

    cpu_architecture = "X86_64"

  }

  container_definitions = jsonencode([

    {

      name = "frontend"

      image = "${aws_ecr_repository.frontend.repository_url}:latest"

      essential = true

      portMappings = [

        {

          containerPort = 3000

          hostPort = 3000

          protocol = "tcp"

        }

      ]

      environment = [

        {

          name = "BACKEND_URL"

          value = "http://backend.service.local:5000"

        }

      ]

      logConfiguration = {

        logDriver = "awslogs"

        options = {

          awslogs-group = aws_cloudwatch_log_group.frontend.name

          awslogs-region = var.region

          awslogs-stream-prefix = "frontend"

        }

      }

    }

  ])

}

#########################################################
# BACKEND ECS SERVICE
#########################################################

resource "aws_ecs_service" "backend" {

  name = "backend"

  cluster = aws_ecs_cluster.main.id

  task_definition = aws_ecs_task_definition.backend.arn

  desired_count = var.backend_desired_count

  launch_type = "FARGATE"

  scheduling_strategy = "REPLICA"

  enable_execute_command = true

  deployment_minimum_healthy_percent = 100

  deployment_maximum_percent = 200

  network_configuration {

    subnets = [

      aws_subnet.public_1.id,

      aws_subnet.public_2.id

    ]

    security_groups = [

      aws_security_group.backend_sg.id

    ]

    assign_public_ip = true

  }

  service_registries {

    registry_arn = aws_service_discovery_service.backend.arn

  }

  depends_on = [

    aws_ecs_cluster.main,

    aws_cloudwatch_log_group.backend,

    aws_iam_role_policy_attachment.ecs_task_execution_policy

  ]

  tags = {

    Name = "backend-service"

  }

}

#########################################################
# FRONTEND ECS SERVICE
#########################################################

resource "aws_ecs_service" "frontend" {

  name            = "frontend"

  cluster         = aws_ecs_cluster.main.id

  task_definition = aws_ecs_task_definition.frontend.arn

  desired_count   = var.frontend_desired_count

  launch_type     = "FARGATE"

  scheduling_strategy = "REPLICA"

  enable_execute_command = true

  deployment_minimum_healthy_percent = 100

  deployment_maximum_percent = 200

  network_configuration {

    subnets = [

      aws_subnet.public_1.id,

      aws_subnet.public_2.id

    ]

    security_groups = [

      aws_security_group.frontend_sg.id

    ]

    assign_public_ip = true

  }

  load_balancer {

    target_group_arn = aws_lb_target_group.frontend.arn

    container_name = "frontend"

    container_port = 3000

  }

  service_registries {

    registry_arn = aws_service_discovery_service.frontend.arn

  }

  depends_on = [

    aws_lb_listener.http,

    aws_ecs_service.backend,

    aws_cloudwatch_log_group.frontend,

    aws_iam_role_policy_attachment.ecs_task_execution_policy

  ]

  tags = {

    Name = "frontend-service"

  }

}