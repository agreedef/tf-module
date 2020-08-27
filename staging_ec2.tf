module "ec2" {
  source = "./ec2"

  name      = "staging"
  type      = "t2.micro"
  key       = "hyunjin-kim-megazone" 
  ami       = "ami-0bd7691bf6470fe9c"
  subnet_id = "subnet-0e59e27cb2fa71f5f"
  private_subnet_ids = ["subnet-0fb222b32a5c34853", "subnet-0dd4e3308a926429a"]
  security_group_ids = ["sg-0db1b167fcf4cd08b", "sg-06ecf724ce45534db"]

  azs            = ["ap-northeast-2a", "ap-northeast-2c"]

  tags = {
    "TerraformManaged" = "true"
  }
}
