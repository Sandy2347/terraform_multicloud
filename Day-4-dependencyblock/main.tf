# resource "aws_instance" "ec2" {
# ami =  "ami-00a929b66ed6e0de6"
# instance_type   = "t2.nano"
# depends_on = [ aws_vpc.devvpc] 
# }

# resource "aws_vpc" "devvpc" {   
# cidr_block = "10.0.0.0/24"
# # enable_dns_support = true
# # enable_dns_hostnames = true 
# tags = {
#     Name        = "TerraformVPCforDev"
#     Environment = "dev"
#   }


# }
resource "aws_s3_bucket" "statefile_bucket_s3" {
  bucket = "sj-terraform-statefile-bucket"
  tags = {
    Name        = "TerraformStateFileBucket"
    Environment = "dev"
  }
  
}