data "aws_iam_policy_document" "assume_role_lambda" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "lambda_dynamo_policy" {
  statement {
    sid    = "EnableDynamos"
    effect = "Allow"
    actions = [
      "dynamodb:PutItem"
    ]
    resources = [aws_dynamodb_table.Clothes_itmes_table.arn]
  }
}
data "archive_file" "get_item" {
  type        = "zip"
  source_file = "lambdas/get_item.py"
  output_path = "get_item.zip"
}
data "archive_file" "post_item" {
  type        = "zip"
  source_file = "lambdas/post_item.py"
  output_path = "post_item.zip"
}
data "archive_file" "put_item" {
  type        = "zip"
  source_file = "lambdas/put_item.py"
  output_path = "put_item.zip"
}
data "archive_file" "delete_item" {
  type        = "zip"
  source_file = "lambdas/delete_item.py"
  output_path = "delete_item.zip"
}
