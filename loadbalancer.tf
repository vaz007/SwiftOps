# Create Application Load Balancer (ALB)
resource "aws_lb" "alb" {
  count              = var.use_aws ? 1 : 0
  name               = "Main-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg[0].id]
  subnets            = aws_subnet.public_subnets[*].id
}

# Create Network Load Balancer (NLB)
resource "aws_lb" "nlb" {
  count              = var.use_aws ? 1 : 0
  name               = "Main-NLB"
  internal           = true
  load_balancer_type = "network"
  subnets            = aws_subnet.private_subnets[*].id
}

# Create security group for ALB
resource "aws_security_group" "alb_sg" {
  count  = var.use_aws ? 1 : 0
  name   = "ALB Security Group"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}