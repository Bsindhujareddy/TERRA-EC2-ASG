output "asg_name" {
  description = "Auto Scaling Group Name"
  value       = aws_autoscaling_group.asg.name
}

output "launch_template_id" {
  description = "Launch Template ID"
  value       = aws_launch_template.lt.id
}

output "security_group_id" {
  description = "Security Group ID"
  value       = aws_security_group.ec2_sg.id
}
output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}