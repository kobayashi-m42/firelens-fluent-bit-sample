provider "aws" {
  profile = var.profile
  region = lookup(
    var.common,
    "${terraform.workspace}.region",
    var.common["default.region"],
  )
}
