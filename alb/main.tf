resource "aws_lb" "this" {
  name = var.name
  internal = false
  load_balancer_type = var.type
  security_groups = var.security_groups
  subnets = var.subnets

  enable_deletion_protection = true

  tags = map("Name", format("%s-alb", var.name))
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port = "80"
  protocol = "HTTP"
  
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_lb_target_group" "this" {
  name = var.target_group_name
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
}

resource "aws_lb_target_group_attachment" "this" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id = var.instance_id
  port = 80
}
