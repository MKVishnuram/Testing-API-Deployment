module "ecs" {
  source           = "../modules/ecs"
  env              = "dev"
  service_name     = "fastapi-app"
  image_tag        = var.image_tag
  execution_role_arn = var.execution_role_arn
  task_role_arn      = var.task_role_arn
  subnets          = var.subnets
  security_groups  = var.security_groups
}

variable "image_tag" {
  description = "Docker image tag to deploy"
  type        = string
}
variable "execution_role_arn" {
  description = "IAM Role ARN for ECS Execution"
  type        = string
}

variable "task_role_arn" {
  description = "IAM Role ARN for ECS Task"
  type        = string
}
