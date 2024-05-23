module "lambda" {
  source                    = "./modules/lambda"
  environment               = var.environment
  managed_policy_arns       = [
    aws_iam_policy.iam_role_mq_lambda_policy.arn,
    aws_iam_policy.iam_role_network_policy.arn,
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]
  lambda_zip_path           = "./dummyData/enode-webhook-v1.zip"
  lambda_security_group_ids = [aws_security_group.main_sg.id]
  private_subnets           = [for subnet in aws_subnet.main_subnet : subnet.id]
  mq_endpoint_ip            = module.mqbroker.mq_broker_endpoint
  broker_username           = var.mq_broker_username
  broker_password           = var.mq_broker_password
}
