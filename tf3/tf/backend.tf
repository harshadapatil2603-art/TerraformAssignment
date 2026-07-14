terraform {


  backend "s3" {

    bucket = "terraform-state-harshada-2630-tf3"

    key = "ecs-fargate/terraform.tfstate"

    region = "ap-south-1"

    dynamodb_table = "terraform-locks"

    encrypt = true

  }

}