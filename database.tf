module "postgres_database" {
  source = "./modules/postgres"

  database_master_username = var.postgres_username
  database_master_password = var.postgres_password
  identifier_prefix = "${var.progres_instance}"
  subnets = []
  publicly_accessible = false
  environment = var.environment
  database-instance-count = 1
  vpc_security_group_ids = [aws_security_group.main_sg.id]
  db_subnet_group_name = aws_db_subnet_group.main_db_subnet_group.name
}
