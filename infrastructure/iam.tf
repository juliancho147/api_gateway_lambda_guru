resource "aws_iam_role" "lambda_role" {
  name               = "lambda_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_lambda.json
}
resource "aws_iam_role_policy_attachment" "lambda_basic" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.name
}
resource "aws_iam_policy" "policy_lambda_dynamo" {
  name   = "policy-lambda-dynamo"
  policy = data.aws_iam_policy_document.lambda_dynamo_policy.json
}

resource "aws_iam_policy_attachment" "policy_lambda_dynamo_attachment" {
  name       = "$lambda-role-attachment"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = aws_iam_policy.policy_lambda_dynamo.arn
}