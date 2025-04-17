variable "EC2_ami" {
  description = "EC2 environment variable for ami"
  type        = string
  default     = "ami-00a929b66ed6e0de6"   
  
}

variable "instance_type" {
  description = "EC2 environment variable for instance type"
  type        = string
  default     = "t2.micro"

}

