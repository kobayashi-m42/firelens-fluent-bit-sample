data "aws_iam_policy_document" "task_execution_trust_relationship" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "task_execution_role" {
  name               = "${var.role}-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.task_execution_trust_relationship.json
}

resource "aws_iam_policy_attachment" "task_execution_role_attach" {
  name       = "ecs-task-role-attach"
  roles      = [aws_iam_role.task_execution_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy_document" "task_trust_relationship" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "task_role" {
  name               = "${var.role}-task-role"
  assume_role_policy = data.aws_iam_policy_document.task_trust_relationship.json
}

data "aws_iam_policy_document" "firelens_cloudwatch_policy" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
      "firehose:PutRecordBatch",
      "s3:PutObject",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "task_role_policy" {
  name   = "${var.role}-task-role-policy"
  role   = aws_iam_role.task_role.id
  policy = data.aws_iam_policy_document.firelens_cloudwatch_policy.json
}
