resource "aws_instance" "name" {
    ami = var.EC2_ami
    instance_type = var.instance_type
  
  tags = {
    Name = "Dev Ec2 Instance" 
    Environment = "Dev"
    Owner = "DevOps"
    Project = "Terraform"
    Application = "WebApp"
    Version = "1.0" 
    CostCenter = "CC12345"
    Department = "IT"
    Region = "us-east-1"
    AvailabilityZone = "us-east-1b"
  }
}