resource "aws_cloudwatch_log_group" "api_gw" {
  name              = "/aws/apigateway/api_gw"
  retention_in_days = 7
}