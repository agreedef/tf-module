resource "aws_rds_cluster_instance" "this" {
  count = 2

  identifier = "aurora-mysql-instance-${count.index}"
  cluster_identifier = aws_rds_cluster.default.id
  instance_class = var.type
  engine = var.engine
  engine_version = var.aurora_version
  db_parameter_group_name = var.instance_parameter_group 
}

resource "aws_rds_cluster" "default" {
  
  cluster_identifier = var.identifier
  availability_zones = var.azs
  database_name = var.name
  master_username = var.username
  master_password = var.password
  engine = var.engine
  engine_version = var.aurora_version
  db_subnet_group_name = var.subnet_group

  vpc_security_group_ids = [
    var.security_group_ids[0]
  ]

  db_cluster_parameter_group_name = var.parameter_group
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
}
