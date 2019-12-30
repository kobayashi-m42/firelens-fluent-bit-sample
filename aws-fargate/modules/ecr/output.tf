output "ecr" {
  value = {
    "app_image_url"       = aws_ecr_repository.app.repository_url
    "logrouter_image_url" = aws_ecr_repository.logrouter.repository_url
  }
}
