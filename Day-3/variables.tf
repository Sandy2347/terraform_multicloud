variable "ami" {
  description = "AMI ID for the instance"
  type        = string
  default = "ami-00a929b66ed6e0de6"  
  
}
variable "instance_type" {
  description = "Type of instance to create"
  type        = string
  default     = "t2.micro"
}