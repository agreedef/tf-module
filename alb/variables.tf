variable "name" {
  description = "ALB Name"
}

variable "type" {
  description = "ELB 타입"
}

variable "subnets" {
  description = "ELB 서브넷 목록"
}

variable "security_groups" {
  description = "ELB 보안그룹 리스트"
}

variable "target_group_name" {
  description = "ELB Target Group Name"
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "instance_id" {
  description = "ELB Target Instance ID"
}

