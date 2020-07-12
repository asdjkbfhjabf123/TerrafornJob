provider "aws" {
  region = "us-east-2"
   shared_credentials_file = "/home/ec2-user/.aws/credentials"
}
terraform {
  required_version = ">= 0.12"
}
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}
resource "aws_instance" "AWSServer1" {
  ami           = "ami-0a54aef4ef3b5f881"
  instance_type = "t2.micro"
  key_name        = "DockerLinux"
  security_groups = ["launch-wizard-7"]
  tags = {
    Name = "Terraform Server1"
  }
}
resource "aws_instance" "AWSServer2" {
  ami           = "ami-0a54aef4ef3b5f881"
  instance_type = "t2.micro"
  key_name        = "DockerLinux"
  security_groups = ["launch-wizard-7"]
  tags = {
    Name = "Terraform Server2"
  }

}
output "ip"{
value= "${aws_instance.web.public_ip}"
}
