provider "aws" {
  profile = "cloud_user"
  region  = "us-east-1"
}

resource "aws_key_pair" "pinky1" {
  key_name   = "pinky1"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "pinky1" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "pinky1.pem"
}

## To create the security group and specifying the ports 

resource "aws_security_group" "pinky_sg" {
  name_prefix = "pinky_sg"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

##  To create ec2 instance
resource "aws_instance" "pinky_1_server" {
  ami               = "ami-0557a15b87f6559cf"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  depends_on = [
    aws_key_pair.pinky1
  ]
  security_groups = [aws_security_group.pinky_sg.name]
  user_data = templatefile("nginx.sh.tpl", {
    user = "Michelle"
  })
  key_name = "pinky1"
  tags = {
    Name = "pinky_1_server"
    User = "ubuntu"
  }
}

## To dispaly the username as output
output "ec2_username" {
  value = aws_instance.pinky_1_server.tags.User
}
## To dispaly the public_ip as output
output "public_ip" {
  value = aws_instance.pinky_1_server.public_ip
}
## To dispaly the public_dns as output
output "public_dns" {
  value = aws_instance.pinky_1_server.public_dns
}
 