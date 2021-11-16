resource "aws_security_group" "app-sg" {
  count          = var.subnet_count
  name   = var.app_sg_name
  vpc_id = aws_vpc.zeta.id

  # HTTP access from VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.public[count.index]]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
      name = "App SG"
  }
}