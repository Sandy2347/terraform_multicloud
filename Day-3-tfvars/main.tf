
#ec2 instance and s3 bucket for dev 
resource "aws_instance" "dev_ec2" {
  ami = var.dev_ami
  instance_type = var.dev_instance_type
  tags = {
    Name        = "TerraformInstancefordev"
    Environment = "Dev"
  }
}


resource "aws_s3_bucket" "dev_s3" {
bucket = var.dev_bucket_name
  tags   = {
    Name        = "TerraformBucketfordev"
    Environment = "dev"
    
  }
  
}



#S3 Bucket  and ec2 instance for test
resource "aws_s3_bucket" "test_s3" {
bucket = var.test_bucket_name
  tags   = {
    Name        = "TerraformBucketfortest"
    Environment = "test"
    
  }
  
}

resource "aws_instance" "test_Ec2" {
 ami = var.test_ami
  instance_type = var.test_instance_type
  tags = {
    Name        = "TerraformInstancefortest"
    Environment = "test"
  } 
}