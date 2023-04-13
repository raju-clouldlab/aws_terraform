#!/bin/bash
#This will store the output of all commands in pinky1_log file 
exec > >(tee /var/log/pinky1_log) 2>&1

# Install Nginx
sudo apt-get update
sudo apt-get install nginx -y

# Create a simple HTML page
sudo sh -c 'echo "<html><body><h1>Hello ${user} Welcome to my Nginx server!</h1></body></html>" > /var/www/html/index.html'

# Configure Nginx to serve the page on endpoint using HTTP port 8080
sudo sh -c 'echo "server {
  listen 8080;
  root /var/www/html;
  index index.html;
}" > /etc/nginx/sites-available/default'

# Configure logfile named "pinkylogs" to check commands that run successfully
sudo sh -c 'echo "error_log /var/log/nginx/pinkylogs error;" >> /etc/nginx/nginx.conf'

# Restart Nginx to apply changes
sudo systemctl restart nginx

# Change hostname
sudo hostnamectl set-hostname pinky_1

# Update /etc/hosts file
sudo sed -i 's/^127.0.1.1.*/127.0.1.1 pinky_1/' /etc/hosts

# we need to reboot the instance to apply the changes
sudo reboot