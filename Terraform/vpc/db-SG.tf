resource "aws_security_group" "db-sg" {
  count          = var.subnet_count
  name   = var.db_sg_name
  vpc_id = aws_vpc.zeta.id

# Oracle DB port
  ingress {
    from_port   = 1521
    to_port     = 1521
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.public[count.index]]
  }

# Postgres DB port
    ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.public[count.index]]
  }

# MySQL DB port
    ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.public[count.index]]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
      name = "DB SG"
  }
}