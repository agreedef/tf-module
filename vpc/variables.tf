variable "name" {
  description = "모듈에서 정의하는 모든 리소스 이름의 prefix"
}

variable "cidr" {
  description = "VPC에 할당한 CIDR block"
}

variable "public_subnets" {
  description = "Public Subnet IP 리스트"
}

variable "private_subnets" {
  description = "Private Subnet IP 리스트"
}

variable "database_subnets" {
  description = "Database Subnet IP 리스트"
}

variable "azs" {
  description = "사용할 availability zones 리스트"
}

variable "tags" {
  description = "모든 리소스에 추가되는 tag 맵"
}
