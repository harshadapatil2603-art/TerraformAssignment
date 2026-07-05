resource "aws_instance" "backend" {

  ami=var.ami

  instance_type=var.instance_type

  subnet_id=aws_subnet.public.id

  key_name=var.key_name

  vpc_security_group_ids=[aws_security_group.backend.id]

  user_data=file("${path.module}/userdata-backend.sh")

  tags={
    Name="Flask-Backend"
  }

}

resource "aws_instance" "frontend" {

  ami=var.ami

  instance_type=var.instance_type

  subnet_id=aws_subnet.public.id

  key_name=var.key_name

  vpc_security_group_ids=[aws_security_group.frontend.id]

  user_data=templatefile("${path.module}/userdata-frontend.sh",{

      backend_ip=aws_instance.backend.private_ip

  })

  depends_on=[aws_instance.backend]

  tags={
    Name="Express-Frontend"
  }

}