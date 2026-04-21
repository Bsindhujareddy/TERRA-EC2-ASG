variable "region" {
  default = "us-east-1"
}

variable "vpc_id" {
  description = "VPC ID where ASG will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "Public subnet IDs"
  type        = list(string)
}

variable "ami_id" {
  description = "AMI ID for EC2"
  type        = string
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "EC2 Key Pair"
  type        = string
}

variable "asg_desired_capacity" {
  default = 2
}

variable "asg_max_size" {
  default = 3
}

variable "asg_min_size" {
  default = 1
}