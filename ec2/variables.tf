variable "ami" {
  description = "EC2 AMI ID"
}

variable "name" {
  description = "모듈에서 정의하는 모든 리소스 이름의 prefix"
}

variable "type" {
  description = "EC2 타입"
}

variable "key" {
  description = "EC2 Key-pair 명"
}

variable "tags" {
  description = "모든 리소스에 추가되는 tag 맵"
}

variable "azs" {
  description = "사용할 availability zones 리스트"
}

variable "subnet_id" {
  description = "bastion EC2 instance Subnet ID"
}

variable "private_subnet_ids" {
  description = "web EC2 instance Subnet ID 리스트"
}

variable "security_group_ids" {
  description = "bastion EC2 instance SecurityGroup ID 리스트"
}
