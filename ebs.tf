module "ebs_instance" {
  source = "./modules/ebs"

  ec2-instance-type = var.ec2-instance-type
  ec2-instance-min-size = var.ec2-instance-min-size
  ec2-instance-max-size = var.ec2-instance-max-size
  subnets = []
  environment = var.environment
}
