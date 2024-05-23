resource "aws_iam_role" "enode_lambda_exec" {
  name = "enode-lambda-${var.environment}"

  managed_policy_arns = var.managed_policy_arns

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_s3_bucket" "ENODE_BUCKET" {
  bucket = "enode-webhook-${var.environment}"
}

resource "aws_s3_object" "ENODE_OBJECT" {
  bucket       = aws_s3_bucket.ENODE_BUCKET.id
  key          = "enode-webhook-v1.zip"
  content_type = "application/zip"
  source       = var.lambda_zip_path
}

resource "aws_lambda_function" "enode_function" {
  function_name = "enode_lambda_function-${var.environment}"
  timeout       = 30

  s3_bucket = aws_s3_bucket.ENODE_BUCKET.id
  s3_key    = aws_s3_object.ENODE_OBJECT.key
  
  runtime = "provided.al2"
  handler = "bootstrap"

  role = aws_iam_role.enode_lambda_exec.arn

  vpc_config {
    security_group_ids = var.lambda_security_group_ids
    subnet_ids         = var.private_subnets
  }

  environment {
    variables = {
      MQ_ENDPOINT_IP  = var.mq_endpoint_ip
      BROKER_USERNAME = var.broker_username
      BROKER_PASSWORD = var.broker_password
    }
  }
}

output "enode_function_invoke_arn" {
  value = aws_lambda_function.enode_function.invoke_arn
}

output "enode_function_name" {
  value = aws_lambda_function.enode_function.function_name
}
