#!/bin/bash

sudo yum update

sudo yum install nginx -y

sudo systemctl start nginx

sudo rm /usr/share/nginx/html/index.html

echo "<html> <h1>Welcome to nginx! host 1 </h1> </html>" | sudo tee /usr/share/nginx/html/index.html