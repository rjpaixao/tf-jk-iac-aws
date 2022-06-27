terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.19.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

# Configuração do Módulo VPC

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  name                = var.vpc_name
  cidr                = var.vpc_cidr
  azs                 = var.vpc_azs
  private_subnets     = var.vpc_private_subnets
  public_subnets      = var.vpc_public_subnets  
  enable_nat_gateway  = var.vpc_enable_nat_gateway
  tags                = var.vpc_tags
  security_group      = var.vpc_secutity_group
}

#Create security group with firewall rules
resource "aws_security_group" "my_security_group" {
  name        = var.security_group
  description = "security group for Ec2 instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 # outbound from jenkis server
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = var.security_group
  }
}

# Criação da Instância EC2

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.0.0"
  
  for_each = toset(["one", "two", "three"])

  name = "instance-${each.key}"

  ami                    = "ami-08d4ac5b634553e16"
  instance_type          = "t2.micro"
  key_name               = "DevOps"
  monitoring             = true
  security_group         = module.vpc_secutity_group
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
