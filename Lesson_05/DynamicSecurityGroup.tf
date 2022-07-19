#-------------------------------------------------------------------------------
# My Terraform 
#
# Build Web server during bootstrap 
#
#
#-------------------------------------------------------------------------------

provider "aws" {
  #region     = "eu-central-1"
}

resource "aws_security_group" "my_webserver" {
  name        = "webserver security group"
  description = "webserver security group"


  dynamic "ingress" {
    for_each = ["80", "443", "8080", "1541", "9092"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "WebServer built by Terraform"
    Owner = "Viktor"
  }

}
