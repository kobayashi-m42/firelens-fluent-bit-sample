resource "aws_ecr_repository" "app" {
  name = "${terraform.workspace}-firelens-sample"
}

resource "aws_ecr_repository" "logrouter" {
  name = "${terraform.workspace}-firelens-sample-logrouter"
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
