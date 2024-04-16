

resource "aws_elastic_beanstalk_application" "tftest" {
  name        = "tf-test-name"
  description = "tf-test-desc"
}

data "aws_elastic_beanstalk_solution_stack" "latest_docker" {
  most_recent = true
  name_regex  = ".*Amazon Linux 2.*running Docker.*"
}


resource "aws_elastic_beanstalk_environment" "tfenvtest" {
  name                = "tf-test-name"
  application         = aws_elastic_beanstalk_application.tftest.name
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
    value     = var.ec2-instance-minSize
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = var.ec2-instance-maxSize
  }

    setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs"
    name      = "StreamLogs"
    value     = "true"
  }



 setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = module.vpc.vpc_id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", module.vpc.public_subnets)
  }

    setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"  # Specify the setting for attaching security groups
    value     = aws_security_group.aurora.id
  }

}
