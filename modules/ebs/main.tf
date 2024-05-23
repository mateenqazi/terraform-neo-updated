

resource "aws_elastic_beanstalk_application" "ebs_neocharge_application" {
  name        = "neocharge-application-${var.environment}"
  description = "tf-test-desc"
}

data "aws_elastic_beanstalk_solution_stack" "latest_docker" {
  most_recent = true
  name_regex  = ".*Amazon Linux 2.*running Docker.*"
}

# Green Environment
resource "aws_elastic_beanstalk_environment" "green" {
  name                = "neocharge-green-${var.environment}"
  application         = aws_elastic_beanstalk_application.ebs_neocharge_application.name
  solution_stack_name = data.aws_elastic_beanstalk_solution_stack.latest_docker.name
  # Additional settings...

   setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpc_id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", var.subnets)
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = "true"
  }


  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = join(",", var.security_groups)
  }

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

  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "DeploymentPolicy"
    value     = "Immutable"
  }
}