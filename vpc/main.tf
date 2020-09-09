# module 의 리소스를 정의한다.

resource "aws_vpc" "this" {
  cidr_block           = var.cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = merge(var.tags, map("Name", format("%s", var.name)))
}


########### IGW ###########
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, map("Name", format("%s", var.name)))
}


########### EIP ###########
resource "aws_eip" "nat" {
  count = length(var.azs)

  vpc = true
}


########### NAT-G ###########
resource "aws_nat_gateway" "this" {
  count = length(var.azs)

  allocation_id = aws_eip.nat.*.id[count.index]
  subnet_id     = aws_subnet.public.*.id[count.index]
}


########### Public route table ###########
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(var.tags, map("Name", format("%s-public", var.name)))
}


########### Private route table ###########
resource "aws_route_table" "private" {
  count = length(var.azs)

  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.*.id[count.index]
  }

  tags = merge(var.tags, map("Name", format("%s-private-%s", var.name, var.azs[count.index])))
}


########### Route table association ###########
resource "aws_route_table_association" "public" {
  count = length(var.public_subnets)

  subnet_id      = aws_subnet.public.*.id[count.index]
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnets)

  subnet_id      = aws_subnet.private.*.id[count.index]
  route_table_id = aws_route_table.private.*.id[count.index]
}

resource "aws_route_table_association" "database" {
  count = length(var.database_subnets)

  subnet_id      = aws_subnet.database.*.id[count.index]
  route_table_id = aws_route_table.private.*.id[count.index]
}


########### SecurityGroup ###########
resource "aws_default_security_group" "dev_default" {
  vpc_id = aws_vpc.this.id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, map("Name", format("%s-default", var.name)))
}

resource "aws_security_group" "staging_bastion" {
  vpc_id = aws_vpc.this.id
  name = format("%s-bastion", var.name)
  
  ingress {
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port   = 22
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, map("Name", format("%s-bastion", var.name)))

}

resource "aws_security_group" "staging_web" {
  vpc_id = aws_vpc.this.id
  name = format("%s-web", var.name)

  ingress {
    protocol  = "tcp"
    cidr_blocks = [var.cidr]
    from_port = 22
    to_port   = 22
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, map("Name", format("%s-web", var.name)))

}

resource "aws_security_group" "staging_alb" {
  vpc_id = aws_vpc.this.id
  name = format("%s-alb", var.name)

  ingress {
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 80
    to_port   = 80
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, map("Name", format("%s-alb", var.name)))

}


########### Subnet ###########
resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(var.tags, map("Name", format("%s-public-%s", var.name, var.azs[count.index])))
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(var.tags, map("Name", format("%s-private-%s", var.name, var.azs[count.index])))
}

resource "aws_subnet" "database" {
  count = length(var.database_subnets)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.database_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(var.tags, map("Name", format("%s-db-%s", var.name, var.azs[count.index])))
}


########### Subnet Group ###########
#resource "aws_db_subnet_group" "database" {
#  count = length(var.database_subnets) > 0 ? 1 : 0
#
#  name        = var.name
#  description = "Database subnet group for ${var.name}"
#  subnet_ids  = [aws_subnet.database.*.id]
#
#  tags = merge(var.tags, map("Name", format("%s", var.name)))
#}
