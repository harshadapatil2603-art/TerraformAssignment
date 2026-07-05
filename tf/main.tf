resource "aws_security_group" "web" {

  name = "flask-express-sg"

  ingress {

    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {

    from_port = 3000
    to_port = 3000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {

    from_port = 5000
    to_port = 5000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {

    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}

resource "aws_instance" "app" {

  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name

  vpc_security_group_ids = [
    aws_security_group.web.id
  ]

  user_data = file("userdata.sh")

  tags = {

    Name = "FlaskExpressServer"

  }

}