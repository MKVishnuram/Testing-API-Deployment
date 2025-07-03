variable "env" {}
variable "service_name" {}
variable "image_tag" {}
variable "execution_role_arn" {}
variable "task_role_arn" {}
variable "subnets" {
  type = list(string)
}
variable "security_groups" {
  type = list(string)
}
variable "aws_region" {}
variable "aws_account_id" {}
