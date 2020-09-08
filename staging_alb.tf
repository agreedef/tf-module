module "alb" {
  source = "./alb"

  name = "staging-alb"
  type = "application"
  security_groups = ["sg-064fa5c6853001b5a"]
  subnets = ["subnet-0e59e27cb2fa71f5f", "subnet-06f1681b18270826e"]

  target_group_name = "staging-alb-tg"
  vpc_id = "vpc-0a6269dff894838f9"
  instance_id = "i-0c827017a106f3bea"
}
