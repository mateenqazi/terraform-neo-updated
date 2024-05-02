

resource "aws_elastic_beanstalk_application" "ebs_neocharge_application" {
  name        = "neocharge-application-${var.environment}"
  description = "tf-test-desc"
}

data "aws_elastic_beanstalk_solution_stack" "latest_docker" {
  most_recent = true
  name_regex  = ".*Amazon Linux 2.*running Docker.*"
}

# Blue environment
resource "aws_elastic_beanstalk_environment" "blue_environment" {
  name                = "neocharge-blue-${var.environment}"
  application         = aws_elastic_beanstalk_application.ebs_neocharge_application.name
  solution_stack_name = data.aws_elastic_beanstalk_solution_stack.latest_docker.name 

   setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.ec2-instance-type
  }

   setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }

    setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = var.ec2-instance-min-size
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = var.ec2-instance-max-size
  }

    setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs"
    name      = "StreamLogs"
    value     = "true"
  }
  // HTTPS listener settings
  setting {
    namespace = "aws:elb:listener:443"
    name      = "ListenerProtocol"
    value     = "HTTPS"
  }

  setting {
    namespace = "aws:elb:listener:443"
    name      = "InstanceProtocol"
    value     = "HTTP"
  }

  setting {
    namespace = "aws:elb:listener:443"
    name      = "InstancePort"
    value     = "80"
  }

  setting {
    namespace = "aws:elb:listener:443"
    name      = "SSLCertificateId"
    value     = "arn:aws:acm:us-west-1:624543228111:certificate/522f2f53-e1ac-40e2-a4ac-a41e33b31a26"
  }
}

# # Green environment
# resource "aws_elastic_beanstalk_environment" "green_environment" {
#   name                = "neocharge-green-${var.environment}"
#   application         = aws_elastic_beanstalk_application.ebs_neocharge_application.name
#   solution_stack_name = data.aws_elastic_beanstalk_solution_stack.latest_docker.name 

#  setting {
#     namespace = "aws:autoscaling:launchconfiguration"
#     name      = "InstanceType"
#     value     = var.ec2-instance-type
#   }

#    setting {
#     namespace = "aws:autoscaling:launchconfiguration"
#     name      = "IamInstanceProfile"
#     value     = "aws-elasticbeanstalk-ec2-role"
#   }

#     setting {
#     namespace = "aws:autoscaling:asg"
#     name      = "MinSize"
#     value     = var.ec2-instance-min-size
#   }

#   setting {
#     namespace = "aws:autoscaling:asg"
#     name      = "MaxSize"
#     value     = var.ec2-instance-max-size
#   }

#     setting {
#     namespace = "aws:elasticbeanstalk:cloudwatch:logs"
#     name      = "StreamLogs"
#     value     = "true"
#   }
# }


# resource "aws_elastic_beanstalk_environment" "ebs_neocharge_environment" {
#   name                = "neocharge-env-${var.environment}"
#   application         = aws_elastic_beanstalk_application.ebs_neocharge_application.name
#   solution_stack_name = data.aws_elastic_beanstalk_solution_stack.latest_docker.name 

#   setting {
#     namespace = "aws:autoscaling:launchconfiguration"
#     name      = "InstanceType"
#     value     = var.ec2-instance-type
#   }

#    setting {
#     namespace = "aws:autoscaling:launchconfiguration"
#     name      = "IamInstanceProfile"
#     value     = "aws-elasticbeanstalk-ec2-role"
#   }

#     setting {
#     namespace = "aws:autoscaling:asg"
#     name      = "MinSize"
#     value     = var.ec2-instance-min-size
#   }

#   setting {
#     namespace = "aws:autoscaling:asg"
#     name      = "MaxSize"
#     value     = var.ec2-instance-max-size
#   }

#     setting {
#     namespace = "aws:elasticbeanstalk:cloudwatch:logs"
#     name      = "StreamLogs"
#     value     = "true"
#   }

# #  setting {
# #     namespace = "aws:elbv2:listener:443"
# #     name      = "Protocol"
# #     value     = "HTTPS"
# #   }

# #   setting {
# #     namespace = "aws:elbv2:listener:443"
# #     name      = "InstancePort"
# #     value     = "80"
# #   }

# #   setting {
# #     namespace = "aws:elbv2:listener:443"
# #     name      = "InstanceProtocol"
# #     value     = "HTTP"
# #   }

# #   setting {
# #     namespace = "aws:elbv2:listener:443"
# #     name      = "SSLCertificateArns"
# #     value     = "arn:aws:acm:us-west-1:624543228111:certificate/522f2f53-e1ac-40e2-a4ac-a41e33b31a26"
# #   }
  

# #   setting {
# #     namespace = "aws:ec2:vpc"
# #     name      = "VPCId"
# #     value     = module.vpc.vpc_id
# #   }
# # setting {
# #     namespace = "aws:ec2:vpc"
# #     name      = "Subnets"
# #     # value     = join(",", data.aws_subnet_ids.public_subnets.ids) 
# #      value     =  module.vpc.public_subnets
# #   }

# }
