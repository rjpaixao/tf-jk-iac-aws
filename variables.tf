variable "aws_region" {
  description   = "AWS Region"   
  default       = "us-east-1"
  type          = string
}

# Input Variables Definitions

variable "vpc_name" {
  description   = "Name of VPC"
  default       = "Curso"
  type          = string   
}

variable "vpc_cidr" {
  description   = "CIDR Block For VPC"
  default       = "10.0.0.0/16"
  type          = string
}

variable "vpc_azs" {
  description   = "Availability Zones For VPC"
  default       = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
  type          = list(string)
}

variable "vpc_private_subnets" {
  description   = "Private Subnet For VPC"
  default       = ["10.0.1.0/24", "10.0.2.0/24"]
  type          = list(string)
}

variable "vpc_public_subnets" {
  description   = "Public Subnet For VPC"
  default       = ["10.0.101.0/24", "10.0.102.0/24"]
  type          = list(string)
}

variable "vpc_enable_nat_gateway" {
  description   = "Enable Nat Gateway For VPC"
  default       = true
  type          = bool
}

variable "vpc_tags" {
  description   = "Tags To Apply To Resources Created By VPC Module"
  default = {
    Terraform   = "True"
    Environment = "Dev"
  }
  type          = map(string)
}