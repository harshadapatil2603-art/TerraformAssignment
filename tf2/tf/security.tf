resource "aws_security_group" "backend" {

  name="backend-sg"

  vpc_id=aws_vpc.main.id

  ingress {

    from_port=22

    to_port=22

    protocol="tcp"

    cidr_blocks=["0.0.0.0/0"]

  }

  ingress {

    from_port=5000

    to_port=5000

    protocol="tcp"

    cidr_blocks=["10.0.0.0/16"]

  }

  egress {

    from_port=0

    to_port=0

    protocol="-1"

    cidr_blocks=["0.0.0.0/0"]

  }

}

resource "aws_security_group" "frontend" {

  name="frontend-sg"

  vpc_id=aws_vpc.main.id

  ingress {

    from_port=22

    to_port=22

    protocol="tcp"

    cidr_blocks=["0.0.0.0/0"]

  }

  ingress {

    from_port=3000

    to_port=3000

    protocol="tcp"

    cidr_blocks=["0.0.0.0/0"]

  }

  egress {

    from_port=0

    to_port=0

    protocol="-1"

    cidr_blocks=["0.0.0.0/0"]

  }

}