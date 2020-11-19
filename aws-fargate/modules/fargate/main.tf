resource "aws_security_group" "fargate" {
  name = "${var.role}-fargate"

  description = "Security Group to ${var.role}-fargate"
  vpc_id      = var.vpc["vpc_id"]

  tags = {
    Name = "${var.role}-fargate"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_cloudwatch_log_group" "logrouter_error" {
  name = "${var.role}-error"
}

resource "aws_cloudwatch_log_group" "logrouter" {
  name = "${var.role}-logrouter"
}

resource "aws_ecs_cluster" "fargate_cluster" {
  name = "${var.role}-fargate"
}

data "template_file" "fargate_template_file" {
  template = file("${path.module}/task/fargate.json")

  vars = {
    aws_region           = var.common["default.region"]
    app_image_url        = var.ecr["app_image_url"]
    logrouter_image_url  = var.ecr["logrouter_image_url"]
    logrouter_logs_group = aws_cloudwatch_log_group.logrouter.name
    s3_bucket_name       = var.s3_bucket_name
    log_group_name       = "${var.role}-error"
    delivery_stream      = var.delivery_stream_name
  }
}

resource "aws_ecs_task_definition" "fargate" {
  family                = "${var.role}-fargate"
  network_mode          = "awsvpc"
  container_definitions = data.template_file.fargate_template_file.rendered
  cpu = lookup(
    var.fargate,
    "${terraform.workspace}.task_cpu",
    var.fargate["default.task_cpu"],
  )
  memory = lookup(
    var.fargate,
    "${terraform.workspace}.task_memory",
    var.fargate["default.task_memory"],
  )
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.task_execution_role.arn
  task_role_arn            = aws_iam_role.task_role.arn

  depends_on = [aws_cloudwatch_log_group.logrouter]
}
