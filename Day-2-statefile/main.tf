resource "aws_instance" "name" {
  ami = "ami-0e449927258d45bc4"
    instance_type = "t2.micro"
    iam_instance_profile = "ec2-s3-access-devops"
       tags = {
      Name = "Terraform-Instance-day2"
    }
    }
 
