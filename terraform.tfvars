region = "us-east-1"

vpc_id = "vpc-xxxxxxxx"

subnet_ids = [
  "subnet-xxxxxx1",
  "subnet-xxxxxx2"
]

ami_id        = "ami-0c02fb55956c7d316"   # Amazon Linux 2 (us-east-1)
instance_type = "t2.micro"
key_name      = "nikbsoft-key"

asg_desired_capacity = 1
asg_max_size         = 3
asg_min_size         = 1