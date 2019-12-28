resource "aws_security_group" "fargate" {
  name = lookup(
    var.fargate,
    "${terraform.workspace}.name",
    var.fargate["default.name"],
  )
  description = "Security Group to ${lookup(
    var.fargate,
    "${terraform.workspace}.name",
    var.fargate["default.name"],
  )}"
  vpc_id = var.vpc["vpc_id"]

  tags = {
    Name = lookup(
      var.fargate,
      "${terraform.workspace}.name",
      var.fargate["default.name"],
    )
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_cloudwatch_log_group" "fargate" {
  name = lookup(
    var.fargate,
    "${terraform.workspace}.name",
    var.fargate["default.name"],
  )
}

resource "aws_ecs_cluster" "fargate_cluster" {
  name = lookup(
    var.fargate,
    "${terraform.workspace}.name",
    var.fargate["default.name"],
  )
}

data "template_file" "fargate_template_file" {
  template = file("../modules/fargate/task/fargate.json")

  vars = {
    aws_region = lookup(
      var.common,
      "${terraform.workspace}.region",
      var.common["default.region"],
    )
    app_image_url  = var.ecr["app_image_url"]
    aws_logs_group = aws_cloudwatch_log_group.fargate.name
  }
}

resource "aws_ecs_task_definition" "fargate" {
  family = lookup(
    var.fargate,
    "${terraform.workspace}.name",
    var.fargate["default.name"],
  )
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

  depends_on = [aws_cloudwatch_log_group.fargate]
}
