#############################################
# ECS Task Execution Role
#############################################

resource "aws_iam_role" "ecs_task_execution_role" {

  name = "${var.project_name}-ecs-task-execution-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {

          Service = "ecs-tasks.amazonaws.com"

        }

        Action = "sts:AssumeRole"

      }

    ]

  })

  tags = {
    Name = "${var.project_name}-ecs-task-execution-role"
  }
}

#############################################
# Attach AWS Managed ECS Execution Policy
#############################################

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {

  role = aws_iam_role.ecs_task_execution_role.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

#############################################
# ECS Task Role
#############################################

resource "aws_iam_role" "ecs_task_role" {

  name = "${var.project_name}-ecs-task-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {

          Service = "ecs-tasks.amazonaws.com"

        }

        Action = "sts:AssumeRole"

      }

    ]

  })

  tags = {
    Name = "${var.project_name}-ecs-task-role"
  }
}

#############################################
# CloudWatch Logs Policy
#############################################

resource "aws_iam_policy" "cloudwatch_logs" {

  name = "${var.project_name}-cloudwatch-policy"

  description = "Allow ECS tasks to write CloudWatch Logs"

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Action = [

          "logs:CreateLogStream",

          "logs:PutLogEvents",

          "logs:DescribeLogStreams"

        ]

        Resource = "*"

      }

    ]

  })
}

#############################################
# Attach CloudWatch Policy
#############################################

resource "aws_iam_role_policy_attachment" "task_cloudwatch_logs" {

  role = aws_iam_role.ecs_task_role.name

  policy_arn = aws_iam_policy.cloudwatch_logs.arn
}