# main.tf

terraform {

  required_version = ">= 1.5.0"

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {

  region = "us-east-1"
}

# Existing AWS Key Pair Name
variable "key_name" {

  default = "terraform"
}

# Latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux" {

  most_recent = true

  owners = ["amazon"]

  filter {

    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

# Security Group
resource "aws_security_group" "ec2_sg" {

  name = "terraform-ec2-sg"

  ingress {

    description = "SSH"

    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {

    description = "Jenkins"

    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create 2 EC2 Instances
resource "aws_instance" "servers" {

  count = 2

  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  key_name = var.key_name

  vpc_security_group_ids = [
    aws_security_group.ec2_sg.id
  ]

  # 100 GB Root Disk
  root_block_device {

    volume_size = 100
    volume_type = "gp3"
  }

  tags = {

    Name = "terraform-server-${count.index + 1}"
  }
}

# Allocate Elastic IPs
resource "aws_eip" "servers_eip" {

  count = 2

  instance = aws_instance.servers[count.index].id

  domain = "vpc"

  tags = {

    Name = "terraform-eip-${count.index + 1}"
  }
}

# Outputs
output "instance_public_ips" {

  value = aws_eip.servers_eip[*].public_ip
}

output "instance_ids" {

  value = aws_instance.servers[*].id
}