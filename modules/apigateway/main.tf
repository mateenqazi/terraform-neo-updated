resource "aws_apigatewayv2_api" "api_gw" {
  name          = "api-gw-${var.environment}"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_vpc_link" "vpc_link" {
  name               = "vpc-link-${var.environment}"
  security_group_ids = [var.api_gateway_security_group_id]
  subnet_ids         = var.public_subnets
}

resource "aws_apigatewayv2_stage" "api_gw_stage" {
  api_id = aws_apigatewayv2_api.api_gw.id

  name        = "api-gw-stage-${var.environment}"
  auto_deploy = true

  access_log_settings {
    destination_arn = var.log_group_arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
    })
  }
}

resource "aws_apigatewayv2_integration" "api_gw_integration" {
  api_id = aws_apigatewayv2_api.api_gw.id

  integration_uri    = var.lambda_invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "api_gw_route" {
  api_id = aws_apigatewayv2_api.api_gw.id

  route_key = "POST /enode"
  target    = "integrations/${aws_apigatewayv2_integration.api_gw_integration.id}"
}

resource "aws_lambda_permission" "api_gw_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.api_gw.execution_arn}/*/*"
}
