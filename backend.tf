terraform {
  backend "s3" {
    bucket         = "nikbsoft-terraform-state-bucket"   # your S3 bucket
    key            = "asg/terraform.tfstate"             # separate path for ASG
    region         = "us-east-1"
    dynamodb_table = "nikbsoft-terraform-lock-table"
    encrypt        = true
  }
}