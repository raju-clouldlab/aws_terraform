# To create ec2 instance
provider "aws" {
  profile = "cloud_user"
  region  = "us-east-1"
}
resource "aws_instance" "pinky_1" {
  ami               = "ami-0557a15b87f6559cf"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  user_data         = templatefile("nginx.sh.tpl",{
    user = "Michelle"
  })
  key_name          = "server_pinky_key"
  tags = {
    Name = "pinky_1"
    User = "ubuntu"
  }
}

# To dispaly the username as output
output "ec2_username" {
  value = aws_instance.pinky_1.tags.User
}
# To dispaly the public_ip as output
output "public_ip" {
  value = aws_instance.pinky_1.public_ip
}
# To dispaly the public_dns as output
output "public_dns" {
  value = aws_instance.pinky_1.public_dns
}

## To create s3 bucket

resource "aws_s3_bucket" "statestorebucket2" {
  bucket = "statestorebucket2"
  acl    = "private"
  versioning {
    enabled = true
  }
}