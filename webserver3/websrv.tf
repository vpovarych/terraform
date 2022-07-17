# Apache Web server demo

provider "aws" {}

resource "aws_instance" "demo_websrv" {
    ami = "ami-0cff7528ff583bf9a"  # Amazon linux
    count = 2
    instance_type = "t2.micro"
      vpc_security_group_ids      = [aws_security_group.demo_WEB.id]
      user_data = templatefile("script.sh.tpl", {
      f_name = "Viktor",
      L_name = "Povarych",
      names = ["Bob", "John", "Anna"]
      }
      )
}

resource "aws_security_group" "demo_WEB" {
  name        = "WEBserver sec group"
  description = "Allow TLS  traffic"

 /* ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
   cidr_blocks      = ["0.0.0.0/0"]
     }
*/

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