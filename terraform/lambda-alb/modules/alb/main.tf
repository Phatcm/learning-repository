#mention the default vpc, subnet
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}
resource "aws_default_subnet" "default_az1" {
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "Default subnet for ap-southeast-1a"
  }
}
resource "aws_default_subnet" "default_az2" {
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "Default subnet for ap-southeast-1b"
  }
}


#alb_sg
resource "aws_security_group" "alb_sg" {
  name_prefix = "alb_sg"
  description = "Security group for ALB"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "alb security group"
  }
}


#alb
resource "aws_lb" "testALB" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]

  enable_deletion_protection = false

  tags   = {
    Name = "dev-alb"
  }
}

#target group
resource "aws_lambda_permission" "with_lb" {
  statement_id  = "AllowExecutionFromlb"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function
  principal     = "elasticloadbalancing.amazonaws.com"
  source_arn    = aws_lb_target_group.test_tg.arn
}

resource "aws_lb_target_group" "test_tg" {
  name        = "testTG"
  target_type = "lambda"
}


resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.test_tg.arn
  target_id        = var.lambda_arn
  depends_on       = [aws_lambda_permission.with_lb]
}


#listener
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.testALB.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test_tg.arn
  }
}