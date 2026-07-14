#############################
# AWS Region
#############################

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1"
}

#############################
# Project Name
#############################

variable "project_name" {
  description = "Project Name"
  type        = string
  default     = "flask-express-ecs"
}

#############################
# VPC
#############################

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
  default     = "10.0.0.0/16"
}

#############################
# Public Subnet 1
#############################

variable "public_subnet_1_cidr" {
  description = "Public Subnet 1 CIDR"
  type        = string
  default     = "10.0.1.0/24"
}

#############################
# Public Subnet 2
#############################

variable "public_subnet_2_cidr" {
  description = "Public Subnet 2 CIDR"
  type        = string
  default     = "10.0.2.0/24"
}

#############################
# Availability Zones
#############################

variable "availability_zone_1" {
  description = "Availability Zone 1"
  type        = string
  default     = "ap-south-1a"
}

variable "availability_zone_2" {
  description = "Availability Zone 2"
  type        = string
  default     = "ap-south-1b"
}

#############################
# ECS Cluster
#############################

variable "ecs_cluster_name" {
  description = "ECS Cluster Name"
  type        = string
  default     = "flask-express-cluster"
}

#############################
# Container Names
#############################

variable "backend_container_name" {
  description = "Backend Container Name"
  type        = string
  default     = "backend"
}

variable "frontend_container_name" {
  description = "Frontend Container Name"
  type        = string
  default     = "frontend"
}

#############################
# Container Ports
#############################

variable "backend_container_port" {
  description = "Backend Container Port"
  type        = number
  default     = 5000
}

variable "frontend_container_port" {
  description = "Frontend Container Port"
  type        = number
  default     = 3000
}

#############################
# ECS Task CPU
#############################

variable "backend_cpu" {
  description = "Backend CPU"
  type        = number
  default     = 256
}

variable "frontend_cpu" {
  description = "Frontend CPU"
  type        = number
  default     = 256
}

#############################
# ECS Task Memory
#############################

variable "backend_memory" {
  description = "Backend Memory"
  type        = number
  default     = 512
}

variable "frontend_memory" {
  description = "Frontend Memory"
  type        = number
  default     = 512
}

#############################
# ECS Service Desired Count
#############################

variable "backend_desired_count" {
  description = "Number of Backend Tasks"
  type        = number
  default     = 1
}

variable "frontend_desired_count" {
  description = "Number of Frontend Tasks"
  type        = number
  default     = 1
}

#############################
# MongoDB Atlas
#############################

variable "mongo_uri" {
  description = "MongoDB Atlas Connection String"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "MongoDB Database Name"
  type        = string
  default     = "todoDB"
}

variable "collection_name" {
  description = "MongoDB Collection Name"
  type        = string
  default     = "todoItems"
}

#############################
# CloudWatch Logs
#############################

variable "log_retention_days" {
  description = "CloudWatch Log Retention"
  type        = number
  default     = 7
}