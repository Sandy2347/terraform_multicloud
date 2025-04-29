# This is a Terraform script that creates a custom VPC 
# The script defines a VPC with a CIDR block of /16
resource "aws_vpc" "devvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name        = "Terraform VPC "
    Environment = "dev"

  }
}

#Create internet gateway for the VPC
# This resource creates an internet gateway for the VPC defined above and attaches it to the VPC
# The internet gateway allows communication between the VPC and the internet
resource "aws_internet_gateway" "devigw" {
  vpc_id = aws_vpc.devvpc.id
  tags = {
    Name        = "Terraform IGW"
    Environment = "dev"
  }

}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.devvpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name        = "Terraform Public Subnet"
    Environment = "dev"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.devvpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name        = "Terraform Private Subnet"
    Environment = "dev"
  }
}

# Create a route table for the public subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.devvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devigw.id
  }
  tags = {
    Name        = "Terraform Public Route Table"
    Environment = "dev"
  }
}

# Associate the public route table with the public subnet
# This resource associates the public route table with the public subnet defined above
resource "aws_route_table_association" "public_route_table_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

#create NAT gateway for the public subnet
resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name        = "Terraform NAT EIP"
    Environment = "dev"
  }
}

# Create a NAT gateway for the private subnet
# This resource creates a NAT gateway for the private subnet defined above and associates it with the public subnet
resource "aws_nat_gateway" "devnatgw" {
  allocation_id = aws_eip.nat_eip.id          #to associate the NAT gateway with the Elastic IP address
  subnet_id     = aws_subnet.public_subnet.id #to create the NAT gateway with the public subnet
}

#craete a route table for the private subnet
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.devvpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.devnatgw.id #to associate the NAT gateway with the private subnet    
  }
  tags = {
    Name        = "Terraform Private Route Table"
    Environment = "dev"
  }
}

# associate the NAT gateway with the private subnet
resource "aws_route_table_association" "private_route_table_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

# Create a security group for the public subnet
resource "aws_security_group" "public_sg" {
  vpc_id      = aws_vpc.devvpc.id
  name        = "public_sg"
  description = "Allow SSH and HTTP access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/24"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/24"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/24"]
  }

  egress  {
    from_port = 0
    to_port   = 0
    protocol  = "-1" # -1 means all protocols
    # Allows all outbound traffic from the security group to any destination
    cidr_blocks = ["0.0.0.0/24"]
 
  }
}

#Create Key-path for the EC2 instance
# This resource creates a key pair for the EC2 instance defined below
resource "aws_key_pair" "my_keypair" {
  key_name   = "my-ec2-key"              # Name that will appear in AWS
  public_key = file("~/.ssh/id_rsa.pub") # Path to your local public key
}

# Create an EC2 instance in the public subnet
# This resource creates an EC2 instance in the public subnet defined above and associates it with the security group and key pair
resource "aws_instance" "ec2" {
  ami           = "ami-00a929b66ed6e0de6"
  key_name      = aws_key_pair.my_keypair.key_name #to associate the key pair with the EC2 instance
  subnet_id     = aws_subnet.public_subnet.id      #to create the EC2 instance in the public subnet
  instance_type = "t2.micro"
  # security_groups = aws_security_group.public_sg.name #to associate the security group with the EC2 instance old way 
  vpc_security_group_ids = [aws_security_group.public_sg.id] #Recommended way to associate the security group with the EC2 instance
  tags = {
    Name        = "Terraform EC2 Instance"
    Environment = "dev"
  }
}
