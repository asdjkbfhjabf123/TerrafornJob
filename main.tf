provider "aws" {
  region = "us-east-2"
   shared_credentials_file = "/home/ec2-user/.aws/credentials"
}
terraform {
  required_version = ">= 0.12"
}
resource "aws_key_pair" "main" { 
public_key = file(var.public_key_file) 
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
resource "aws_instance" "Worker" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
}
resource "aws_instance" "Master" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
}
resource "null_resource" "create_host_file" {
provisioner "local-exec" {
command = <<-EOF
sudo echo "${aws_instance.Master.public_ip}" | sudo tee /home/ec2-user/hosts
EOF
}
  }
output "ip"{
value= "${aws_instance.Master.public_ip}"
}
