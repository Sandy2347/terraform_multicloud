variable "ami" {
  description = "AMI ID for the instance"
  type        = string
  default = ""  
  
}
variable "instance_type" {
  description = "Type of instance to create"
  type        = string
  default     = ""
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = ""
  
}