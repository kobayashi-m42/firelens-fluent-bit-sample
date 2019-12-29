resource "aws_s3_bucket" "bucket" {
  bucket        = "${var.role}-log"
  force_destroy = true
}

resource "aws_iam_role" "firehose_role" {
  name = "${var.role}-firehose-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "firehose_role_policy" {
  name = "${var.role}-firehose-role-policy"
  role = aws_iam_role.firehose_role.id

  policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
       {
           "Effect": "Allow",
           "Action": [
               "s3:AbortMultipartUpload",
               "s3:GetBucketLocation",
               "s3:GetObject",
               "s3:ListBucket",
               "s3:ListBucketMultipartUploads",
               "s3:PutObject"
           ],
           "Resource": [
               "${aws_s3_bucket.bucket.arn}",
               "${aws_s3_bucket.bucket.arn}/*"
           ]
       }
   ]
}
EOF
}

resource "aws_kinesis_firehose_delivery_stream" "test_stream" {
  name        = "${var.role}-stream"
  destination = "s3"

  s3_configuration {
    role_arn   = aws_iam_role.firehose_role.arn
    bucket_arn = aws_s3_bucket.bucket.arn
  }
}
