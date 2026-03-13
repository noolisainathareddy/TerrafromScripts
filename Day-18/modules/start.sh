#!/bin/bash
sudo dnf install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
sudo echo "<h1>Hello from Nginx on EC2</h1>" > /usr/share/nginx/html/index.html