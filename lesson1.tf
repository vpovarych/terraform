provider "aws" {
    
}

resource "aws_instance" "my_ubuntu" {
ami = "ami-08d4ac5b634553e16"
instance_type = "t1.micro"
count = 3
tags = {
  "Name" = "terraform1"
  owner = "Viktor Povarych"
}
}