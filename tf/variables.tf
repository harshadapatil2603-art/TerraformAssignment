variable "region" {
  default = "ap-south-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "Existing AWS Key Pair"
}

variable "ami" {
  default = "ami-0b40571b9c2387b15"
}