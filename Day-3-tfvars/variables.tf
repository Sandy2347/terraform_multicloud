
#test instance and bucket 
variable "test_ami" {
  description = "AMI ID for the instance"
  type        = string
  default = ""  
  
}


variable "test_instance_type" {
  description = "Type of instance to create"
  type        = string
  default     = ""
}


variable "test_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = ""
  
}

#Dev INstance and bucket

variable "dev_ami" {
  description = "AMI ID for the instance"
  type        = string
  default = ""  
  
}
variable "dev_instance_type" {
  description = "Type of instance to create"
  type        = string
  default     = ""
}



variable "dev_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = ""
  
}

