# Apache Web server demo

provider "aws" {}

resource "aws_instance" "demo_websrv" {
    ami = "ami-0cff7528ff583bf9a"  # Amazon linux
    instance_type = "t2.micro"
      vpc_security_group_ids      = [aws_security_group.demo_WEB.id]
      user_data = <<EOF
#!/bin/bash
sudo yum update -y
sudo yum install httpd -y

echo "Build by Terraform" > /var/www/html/index.html

sudo service httpd start
chkconfig httpd on
EOF
}

resource "aws_security_group" "demo_WEB" {
  name        = "WEBserver sec group"
  description = "Allow TLS  traffic"

  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
   cidr_blocks      = ["0.0.0.0/0"]
     }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
     }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    }

  tags = {
    Name = "allow_tls:80"
  }
}