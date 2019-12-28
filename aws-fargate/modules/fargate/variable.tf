variable "fargate" {
  type = map(string)

  default = {
    "default.name"                  = "prod-firelens-sample"
    "dev.name"                      = "dev-firelens-sample"
    "default.logrouter_name"        = "prod-firelens-sample-logrouter"
    "dev.logrouter_name"            = "dev-firelens-sample-logrouter"
    "default.service_desired_count" = "1"
    "default.task_cpu"              = "256"
    "default.task_memory"           = "512"
  }
}

variable "common" {
  type = map(string)

  default = {}
}

variable "vpc" {
  type = map(string)

  default = {}
}

variable "ecr" {
  type = map(string)

  default = {}
}

data "aws_elb_service_account" "aws_elb_service_account" {}
