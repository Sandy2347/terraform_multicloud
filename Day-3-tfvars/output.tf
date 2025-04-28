
#print Dev instance values 
output "aws_instance" {
  value = aws_instance.dev_ec2.arn
}

output "pubicip" {
  value = aws_instance.dev_ec2.public_ip
}

output "private_ip" {
  value = aws_instance.dev_ec2.private_ip
  
}

output "Environment" {
  value = aws_instance.dev_ec2.tags_all
  
}


