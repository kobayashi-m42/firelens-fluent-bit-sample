variable "common" {
  type = map(string)

  default = {
    "default.region"  = "ap-northeast-1"
    "default.project" = "firelens-sample"
  }
}

locals {
  role = "firelens-fluentbit-sample"
}

variable "profile" {}
