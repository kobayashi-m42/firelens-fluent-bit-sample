resource "aws_ecr_repository" "app" {
  name = "${var.role}-app"
}

resource "aws_ecr_repository" "logrouter" {
  name = "${var.role}-logrouter"
}

locals {
  lifecycle_policy = <<EOF
  {
    "rules": [
      {
        "rulePriority": 10,
        "description": "Expire images count more than 5",
        "selection": {
          "tagStatus": "any",
          "countType": "imageCountMoreThan",
          "countNumber": 5
        },
        "action": {
          "type": "expire"
        }
      }
    ]
  }
EOF
}

resource "aws_ecr_lifecycle_policy" "app" {
  repository = aws_ecr_repository.app.name
  policy     = local.lifecycle_policy
}

resource "aws_ecr_lifecycle_policy" "logrouter" {
  repository = aws_ecr_repository.logrouter.name
  policy     = local.lifecycle_policy
}
