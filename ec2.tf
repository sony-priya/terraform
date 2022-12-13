#by default associate_public_ip_address is false so make sure you change it as true

resource "aws_instance" "web" {
  ami                         = "ami-0b0dcb5067f052a63"
  instance_type               = "t2.micro"
  key_name                    = "web-key"
  subnet_id                   = aws_subnet.public[count.index].id
  vpc_security_group_ids      = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true
  #by default it is false
  count = 2

  tags = {
    Name = "webserver"
  }


  provisioner "file" {
    source      = "./web-key.pem"
    destination = "/home/ec2-user/web-key.pem"

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file("./web-key.pem")
    }
  }
}

resource "aws_instance" "db" {
  ami                    = "ami-0b0dcb5067f052a63"
  instance_type          = "t2.micro"
  key_name               = "web-key"
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.allow_tls_db.id]

  tags = {
    name = "db_server"
  }
}