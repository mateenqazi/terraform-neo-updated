module "mqbroker" {
  source               = "./modules/mqbroker"
  environment          = var.environment
  mq_security_group_id = aws_security_group.main_sg.id
  private_subnet_id    = aws_subnet.main_subnet[0].id
  broker_username      = var.mq_broker_username
  broker_password      = var.mq_broker_password
}
