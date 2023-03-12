provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "cloudlab_ec2" {
  ami           = "ami-005f9685cb30f234b"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  key_name = "cloudlab"
  tags = {
    Name = "cloudlab_ec2"
  }
}