resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "allow tls inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "TLS from vpc"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "tls from vpc"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "allow_tls"
  }
}


resource "aws_security_group" "allow_tls_db" {
  name        = "allow_tls_db"
  description = "allow db tls inbould traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "tls from vpc"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "tls from vpc"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "allow_tls_db"
  }
}