module "apigateway" {
  source                        = "./modules/apigateway"
  environment                   = var.environment
  api_gateway_security_group_id = aws_security_group.main_sg.id
    public_subnets = [
    aws_subnet.main_subnet[0].id,
    aws_subnet.main_subnet[1].id,
  ]

  log_group_arn                 = aws_cloudwatch_log_group.api_gw.arn
  lambda_invoke_arn             = module.lambda.enode_function_invoke_arn
  lambda_function_name          = module.lambda.enode_function_name
}
