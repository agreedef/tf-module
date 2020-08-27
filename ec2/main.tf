resource "aws_instance" "this" {
  count = length(var.azs)-1

  ami = var.ami
  instance_type = var.type
  key_name = var.key
  availability_zone = var.azs[count.index]
  subnet_id = var.subnet_id
  associate_public_ip_address = true

  vpc_security_group_ids = [
    var.security_group_ids[0]
  ]

  tags = merge(var.tags, map("Name", format("%s-bastion", var.name)))
}

resource "aws_instance" "web" {
  count = length(var.azs)

  ami = var.ami
  instance_type = var.type
  key_name = var.key
  availability_zone = var.azs[count.index]
  subnet_id = var.private_subnet_ids[count.index]
  associate_public_ip_address = false

  vpc_security_group_ids = [
    var.security_group_ids[1]
  ]

  tags = merge(var.tags, map("Name", format("%s-web-%s", var.name, var.azs[count.index])))
}

