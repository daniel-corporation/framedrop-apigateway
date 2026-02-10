resource "aws_lb" "nlb" {
  name               = "${var.project_name}-nlb-bridge"
  internal           = true
  load_balancer_type = "network"
  subnets            = data.aws_subnets.private.ids 

  enable_cross_zone_load_balancing = true
  
  tags = {
    Name = "${var.project_name}-nlb-bridge"
  }
}

resource "aws_lb_target_group" "alb_target" {
  name        = "${var.project_name}-tg-alb"
  target_type = "alb"
  port        = 80
  protocol    = "TCP"
  vpc_id      = data.aws_vpc.main.id 
}

resource "aws_lb_target_group_attachment" "tg_attachment" {
  target_group_arn = aws_lb_target_group.alb_target.arn
  target_id        = data.aws_lb.existing_alb.arn 
  port             = 80
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target.arn
  }
}

resource "aws_api_gateway_vpc_link" "this" {
  name        = "${var.project_name}-vpc-link"
  description = "VPC Link conectando API Gateway ao NLB Bridge"
  target_arns = [aws_lb.nlb.arn]
}