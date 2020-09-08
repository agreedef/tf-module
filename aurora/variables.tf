variable "name" {
  description = "데이터베이스 name"
}

variable "identifier" {
  description = "cluster_identifer"
}

variable "type" {
  description = "데이터베이스 type"
}

variable "username" {
  description = "데이터베이스 계정"
}

variable "password" {
  description = "데이터베이스 비밀번호"
}

variable "engine" {
  description = "RDS aurora 유형 정보"
}

variable "aurora_version" {
  description = "RDS aurora 버전"
}

variable "azs" {
  description = "사용할 availability zones 리스트"
}

variable "subnet_group" {
  description = "데이터베이스 서브넷 그룹명"
}

variable "parameter_group" {
  description = "데이터베이스 파라미터 그룹명"
}

variable "instance_parameter_group" {
  description = "데이터베이스인스턴스 파라미터 그룹명"
}

variable "security_group_ids" {
  description = "보안그룹 아이디"
}

