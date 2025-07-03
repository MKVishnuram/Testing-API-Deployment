data "aws_iam_role" "ecs_task_execution" {
  name = "ecsTaskExecutionRole"
}

data "aws_subnets" "all" {}
data "aws_security_group" "default" {
  filter {
    name   = "group-name"
    values = ["default"]
  }
}

module "ecs" {
  source             = "../modules/ecs"
  env                = "dev"
  service_name       = "fastapi-app"
  image_tag          = var.image_tag
  execution_role_arn = data.aws_iam_role.ecs_task_execution.arn
  task_role_arn      = data.aws_iam_role.ecs_task_execution.arn
  subnets            = data.aws_subnets.all.ids
  security_groups    = [data.aws_security_group.default.id]
  aws_region         = var.aws_region
  aws_account_id     = var.aws_account_id
}
