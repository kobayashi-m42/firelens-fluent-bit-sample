variable "role" {}
variable "s3_bucket_name" {}
variable "delivery_stream_name" {}

variable "fargate" {
  type = map(string)

  default = {
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
