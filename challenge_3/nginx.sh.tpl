#!/bin/bash
# Change hostname
sudo hostnamectl set-hostname pinky_1

# Update /etc/hosts file
sudo sed -i 's/^127.0.1.1.*/127.0.1.1 pinky_1/' /etc/hosts

# we need to reboot the instance to apply the changes
sudo reboot

exec > >(tee /var/log/pinky_1log | logger -t user-data -s 2>/dev/console) 2>&1

#This will give the time stamp of the date.
echo "Starting userdata script at $(date)" >> /var/log/pinky_1log 2>&1

# Update package lists using apt-get and store the output of the command in /var/log/pinky_1log file
sudo apt update >> /var/log/pinky_1log 2>&1

# Install nginix and store the output of the command in /var/log/pinky_1log file
sudo apt install nginx -y >> /var/log/pinky_1log 2>&1

# Create index.html and save the created html file in /var/www/html/index.html and store the output of the command in /var/log/pinky_1log file
echo "<html><body><h1>Hello ${user} Welcome to my Nginx server!</h1></body></html>" | sudo tee /var/www/html/index.html >> /var/log/pinky_1log 2>&1

#Configure Nginx to serve index.html on port 8080.
#sed command will modify the default Nginx configuration file at /etc/nginx/sites-available/default. Specifically,it replaces the line "listen 80" with the line "listen 8080".
# The output of the command in /var/log/pinky_1log file.
sudo sed -i 's/listen 80/listen 8080/' /etc/nginx/sites-available/default >> /var/log/pinky_1log 2>&1

#This command restarts the Nginx service to apply the new configuration and store the output of the command in /var/log/pinky_1log file.
sudo systemctl restart nginx

This will give the time stamp of the date
echo "Finished userdata script at $(date)" >> /var/log/pinky_1log 2>&1