#!/bin/bash
yum update -y
yum install httpd -y

echo "Build by Terraform + script" > /var/www/html/index.html
echo "<br><font color='blue'> welcome to AWS world" >> /var/www/html/index.html
sudo service httpd start
chkconfig httpd on