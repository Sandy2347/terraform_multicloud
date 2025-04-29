resource "aws_instance" "ec2" {

  ami           = "ami-00a929b66ed6e0de6"
  instance_type = "t2.micro"
  tags = {
    Name        = "TerraformVPCforDev"
    Environment = "devprod"
  }

  lifecycle {
    # create_before_destroy = true
    prevent_destroy = true
    ignore_changes  = [tags["Name"]]
  }
  # Prevents the resource from being destroyed if the tags["Name"] changes
  # This is useful for resources that are managed outside of Terraform or have a different lifecycle
  # that should not be affected by changes in the tags["Name"]
  # For example, if the instance is part of an autoscaling group or managed by another service
  # you may want to ignore changes to the tags["Name"] attribute
  # and prevent the resource from being destroyed and recreated
}


