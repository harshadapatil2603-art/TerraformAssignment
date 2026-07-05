output "backend_public_ip" {

  value=aws_instance.backend.public_ip

}

output "frontend_public_ip" {

  value=aws_instance.frontend.public_ip

}

output "frontend_url" {

  value="http://${aws_instance.frontend.public_ip}:3000"

}