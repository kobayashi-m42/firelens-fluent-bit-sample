output "ecr" {
  value = {
    "app_image_url" = aws_ecr_repository.app.repository_url
  }
}
