resource "aws_ecr_repository" "repo" {
  name = var.service_name
}

resource "aws_ecs_cluster" "cluster" {
  name = "${var.env}-cluster"
}

resource "aws_ecs_task_definition" "task" {
  family                   = "${var.service_name}-${var.env}"
  container_definitions   = jsonencode([{
    name      = var.service_name
    image     = "${aws_ecr_repository.repo.repository_url}:${var.image_tag}"
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]
  }])
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn
}

resource "aws_ecs_service" "service" {
  name            = "${var.service_name}-${var.env}"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets         = var.subnets
    assign_public_ip = true
    security_groups = var.security_groups
  }
}


