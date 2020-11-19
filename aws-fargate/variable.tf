variable "common" {
  type = map(string)

  default = {
    "default.region"  = "ap-northeast-1"
    "default.project" = "firelens-sample"
  }
}

locals {
  role                 = "firelens-fluentbit-sample"
  s3_bucket_name       = "${local.role}-log"
  delivery_stream_name = "${local.role}-stream"
}

variable "profile" {}
