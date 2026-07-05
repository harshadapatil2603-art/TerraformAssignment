terraform {
  backend "s3" {
    bucket = "harshada-terraform-state-2603"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}