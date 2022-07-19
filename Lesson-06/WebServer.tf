# Build WebServer during Bootstrap
#----------------------------------------------------------

provider "aws" {
  region = "eu-central-1"
}

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_webserver.id
  tags = {
    Name  = "Web Server IP"
    Owner = "vpovarych"
  }
}

resource "aws_instance" "my_webserver" {
  ami                    = "ami-0a1ee2fb28fe05df3"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Viktor",
    l_name = "Povarych",
    names  = [3454, "Vasya", "Kolya", "Petya", "John", "Donald", "Lena"]
  })

  tags = {
    Name  = "Web Server Build by Terraform"
    Owner = "Viktor P"
  }

  lifecycle {
    #prevent_destroy = false
    #ignore_changes = [ami, user_data]
    create_before_destroy = true
  }

}


resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "My First SecurityGroup"

  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Web Server SecurityGroup"
    Owner = "VPovarych"
  }
}
