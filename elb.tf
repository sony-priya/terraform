#load balancer required minimum 2 public subnets

resource "aws_lb" "alb" {
  name               = "test-tb-elf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_tls.id]
  subnets            = [for subnet in aws_subnet.public : subnet.id]

//  enable_delete_protection = false

  tags = {
    Environment = "test"
  }
}

resource "aws_lb_target_group" "albtg" {
  name        = "tf-example"
  port        = 80
  protocol    = "tcp"
  target_type = "instance"
  vpc_id      = aws_vpc.main.id

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
    interval            = 10
    path                = "/"
    port                = 80
  }
}

//adding instances to load balancer
resource "aws_lb_target_group_attachment" "front_end" {
  target_group_arn = aws_lb_target_group.albtg.arn
  target_id        = aws_instance.web[count.index].id
  port             = 80
  count            = 2
}


//listener
resource "aws_lb_listener" "albl" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.albtg.arn
  }
}

