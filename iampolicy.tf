resource "aws_iam_policy" "iam_role_mq_lambda_policy" {
  name        = "IAMRoleMQLambdaPolicy"
  path        = "/"
  description = "IAM policy for accessing MQ from Lambda"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["mq:DescribeBroker", "mq:RebootBroker"],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "iam_role_network_policy" {
  name        = "IAMRoleNetworkPolicy"
  path        = "/"
  description = "IAM policy for accessing network resources"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
       "Action": [
             "ec2:DescribeNetworkInterfaces",
             "ec2:CreateNetworkInterface",
             "ec2:DeleteNetworkInterface",
           ],
        Resource = "*"
      }
    ]
  })
}

# resource "aws_iam_role" "enode_lambda_exec" {
#   name = "unique-enode-lambda-role"
#   assume_role_policy = jsonencode({
#     "Version": "2012-10-17",
#     "Statement": [
#       {
#         "Effect": "Allow",
#         "Principal": {
#           "Service": "lambda.amazonaws.com"
#         },
#         "Action": "sts:AssumeRole"
#       }
#     ]
#   })

#   tags = {
#     Environment = "test"
#     Terraform   = "true"
#   }
# }

# resource "aws_iam_policy" "lambda_execution_policy" {
#   name        = "LambdaExecutionPolicy"
#   description = "Policy for Lambda execution"
#   policy      = jsonencode({
#     "Version": "2012-10-17",
#     "Statement": [
#       {
#         "Effect": "Allow",
#         "Action": [
#           "ec2:CreateNetworkInterface",
#           "ec2:DescribeNetworkInterfaces"
#         ],
#         "Resource": "*"
#       },
#       {
#         "Effect": "Allow",
#         "Action": "ec2:DeleteNetworkInterface",
#         "Resource": "arn:aws:ec2:region:account-id:network-interface/*"
#       }
#     ]
#   })
# }

resource "aws_iam_role_policy_attachment" "lambda_execution_attachment" {
  role       = aws_iam_role.enode_lambda_exec.name
  policy_arn = aws_iam_policy.lambda_execution_policy.arn
}


resource "aws_iam_policy" "lambda_execution_policy" {
  name        = "LambdaExecutionPolicy"
  description = "Policy for Lambda execution"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "ec2:CreateNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "enode_lambda_exec" {
  name             = "unique-enode-lambda-role"  # Specify the name for the IAM role
  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action    = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Environment = "test"
    Terraform   = "true"
  }
}

resource "aws_iam_policy_attachment" "lambda_execution_attachment" {
  roles      = [aws_iam_role.enode_lambda_exec.name] 
  policy_arn = aws_iam_policy.lambda_execution_policy.arn
  name = "lamba-test-policy"
}

