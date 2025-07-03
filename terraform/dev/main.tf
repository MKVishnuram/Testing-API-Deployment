provider "aws" {
  region = var.aws_region
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_security_groups" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

module "ecs" {
  source              = "../modules/ecs"
  env                 = "dev"
  service_name        = "fastapi-app"
  image_tag           = var.image_tag
  aws_region          = var.aws_region           # ✅ add this
  aws_account_id      = var.aws_account_id       # ✅ add this
  execution_role_arn  = var.execution_role_arn
  task_role_arn       = var.task_role_arn
  subnets             = data.aws_subnets.default.ids
  security_groups     = [data.aws_security_groups.default.ids[0]]
}

module "frontend_s3" {
  source    = "../modules/s3_static_site"
  site_name = "testingmyapp"
  env       = "commversemyapp"
}


