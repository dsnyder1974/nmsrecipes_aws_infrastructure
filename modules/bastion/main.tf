##################################
# Bastion Host Module
##################################
# This module creates a Bastion Host in AWS with a security group and key pair.
# It uses the Amazon Linux 2 AMI and allows SSH access from a specified IP address.


resource "aws_key_pair" "bastion_key" {
  lifecycle {
    prevent_destroy = true
    ignore_changes  = [public_key]
  }
  key_name   = "${var.environment_name}-bastion-key"
  public_key = file(var.public_key_path)
}

resource "aws_security_group" "bastion_sg" {
  name        = "${var.environment_name}-bastion-sg"
  description = "Security group for Bastion Host"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_address]
    description = "Allow SSH from my IP"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment_name}-bastion-sg"
  }
}

resource "aws_instance" "bastion_host" {
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = "t3.micro"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  key_name                    = aws_key_pair.bastion_key.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              exec > /var/log/user-data.log 2>&1

              echo "Starting user_data setup"

              yum update -y
              yum install -y vim git unzip htop

              echo "Welcome to the Bastion Host - $(hostname)" > /etc/motd

              echo "Setup complete"
              EOF

  tags = {
    Name = "dev-bastion-host"
  }
}

data "aws_ami" "amazon_linux_2" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
