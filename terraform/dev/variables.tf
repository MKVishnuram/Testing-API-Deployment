
variable "aws_region" {
  description = "AWS region"
  type        = string
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
