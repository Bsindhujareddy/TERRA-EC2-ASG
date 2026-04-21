

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "mnikbsoft-terraform-state-bucket"
    key    = "vpc/terraform.tfstate"
    region = "us-east-1"
  }
}
provider "aws" {
  region = var.region
}

# ----------------------
# Security Group
# ----------------------
resource "aws_security_group" "ec2_sg" {
  name   = "asg-ec2-sg"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ----------------------
# Launch Template
# ----------------------
resource "aws_launch_template" "lt" {
  name_prefix   = "asg-launch-template"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.ec2_sg.id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "ASG-Instance"
    }
  }
}

# ----------------------
# Auto Scaling Group
# ----------------------
resource "aws_security_group" "ec2_sg" {
  name   = "asg-ec2-sg"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  vpc_zone_identifier = data.terraform_remote_state.vpc.outputs.public_subnet_ids

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }

  health_check_type = "EC2"

  tag {
    key                 = "Name"
    value               = "terraform-asg"
    propagate_at_launch = true
  }
}