terraform {
  backend "s3" {
    bucket         = "sj-terraform-statefile-bucket"
    key            = "statefile/terraform.tfstate"
    region         = "us-east-1"
    # dynamodb_table = "terraform-lock-table"
    
  }
}