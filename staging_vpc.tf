module "vpc" {
  source = "./vpc"

  name = "staging"
  cidr = "10.20.0.0/16"

  azs              = ["ap-northeast-2a", "ap-northeast-2c"]
  public_subnets   = ["10.20.1.0/24", "10.20.2.0/24"]
  private_subnets  = ["10.20.101.0/24", "10.20.102.0/24"]
  database_subnets = ["10.20.201.0/24", "10.20.202.0/24"]

  tags = {
    "TerraformManaged" = "true"
  }
}
