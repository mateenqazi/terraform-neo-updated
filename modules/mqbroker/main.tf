resource "aws_mq_broker" "active_mq_broker" {
  broker_name         = "active-mq-broker-${var.environment}"
  engine_type         = "ActiveMQ"
  engine_version      = "5.17.6"
  host_instance_type  = "mq.t2.micro"
  publicly_accessible = false
  security_groups     = [var.mq_security_group_id]
  subnet_ids          = [var.private_subnet_id]

  user {
    username       = var.broker_username
    password       = var.broker_password
    console_access = true
  }
}

data "aws_mq_broker" "active_mq_broker" {
  broker_id = aws_mq_broker.active_mq_broker.id
}

output "mq_broker_endpoint" {
  value = aws_mq_broker.active_mq_broker.instances[0].endpoints[0]
}
