# module "ebs_instance" {
#   source = "./modules/ebs"
#   ec2-instance-type = var.ec2-instance-type
#   ec2-instance-min-size = var.ec2-instance-min-size
#   ec2-instance-max-size = var.ec2-instance-max-size
#   environment = var.environment
#   subnets = aws_subnet.main_subnet[*].id
#   security_groups = [aws_security_group.main_sg.id]
#   vpc_id = aws_vpc.main_vpc.id
# }
