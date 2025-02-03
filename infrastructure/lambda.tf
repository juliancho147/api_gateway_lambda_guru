resource "aws_lambda_function" "lambda_get_item" {
  filename         = "get_item.zip"
  function_name    = "get_item"
  role             = aws_iam_role.lambda_role.arn
  handler          = "get_item.lambda_handler"
  source_code_hash = data.archive_file.get_item.output_base64sha256
  runtime          = "python3.10"
}
resource "aws_lambda_permission" "apigw_lambda_get" {
  statement_id  = "AllowExecutionFromAPIGatewayGet"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_get_item.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.my_api.execution_arn}/*/*"
}

############
resource "aws_lambda_function" "lambda_post_item" {
  filename         = "post_item.zip"
  function_name    = "post_item"
  role             = aws_iam_role.lambda_role.arn
  handler          = "post_item.lambda_handler"
  source_code_hash = data.archive_file.post_item.output_base64sha256
  runtime          = "python3.10"
}
resource "aws_lambda_permission" "apigw_lambda_post" {
  statement_id  = "AllowExecutionFromAPIGatewayPost"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_post_item.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.my_api.execution_arn}/*/*"
}
###############
resource "aws_lambda_function" "lambda_put_item" {
  filename         = "put_item.zip"
  function_name    = "put_item"
  role             = aws_iam_role.lambda_role.arn
  handler          = "put_item.lambda_handler"
  source_code_hash = data.archive_file.put_item.output_base64sha256
  runtime          = "python3.10"
}
resource "aws_lambda_permission" "apigw_lambda_put" {
  statement_id  = "AllowExecutionFromAPIGatewayPut"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_put_item.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.my_api.execution_arn}/*/*"
}
###########
resource "aws_lambda_function" "lambda_delete_item" {
  filename         = "delete_item.zip"
  function_name    = "delete_item"
  role             = aws_iam_role.lambda_role.arn
  handler          = "delete_item.lambda_handler"
  source_code_hash = data.archive_file.delete_item.output_base64sha256
  runtime          = "python3.10"
}
resource "aws_lambda_permission" "apigw_lambda_delete" {
  statement_id  = "AllowExecutionFromAPIGatewayDelete"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_delete_item.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.my_api.execution_arn}/*/*"
}