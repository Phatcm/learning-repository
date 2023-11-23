resource "aws_sqs_queue" "s3-sucess" {
  name = "s3-sucess"
}

resource "aws_sqs_queue" "s3-failure" {
  name = "s3-failure"
}

data "aws_iam_policy_document" "sqs-permission" {
  statement {
    sid    = "First"
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.s3-sucess.arn]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [var.lambda_arn]
    }
  }
}

resource "aws_sqs_queue_policy" "lambda-sucess-queue-policies" {
  queue_url = aws_sqs_queue.s3-sucess.id
  policy    = data.aws_iam_policy_document.sqs-permission.json
}

resource "aws_sqs_queue_policy" "lambda-failure-queue-policies" {
  queue_url = aws_sqs_queue.s3-failure.id
  policy    = data.aws_iam_policy_document.sqs-permission.json
}

