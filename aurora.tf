module "aurora" {
  source = "./aurora"

  name = "staging"
  identifier = "staging-aurora"
  type = "db.t2.small"
  username = "admin"
  password = "123123123"
  engine = "aurora-mysql"
  aurora_version = "5.7.mysql_aurora.2.03.2"
  
  azs = ["ap-northeast-2a", "ap-northeast-2c"]

  subnet_group = "terraform_db_subnet_group"
  parameter_group = "terraform-db-cluster-pg"
  instance_parameter_group = "terraform-db-pg"
  security_group_ids = ["sg-09270e7429bd000af"]
}
