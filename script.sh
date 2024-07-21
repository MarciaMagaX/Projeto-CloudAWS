#!/bin/bash
# Update the package database
sudo apt-get update

# Install Docker
sudo apt-get install -y docker.io

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Download the Docker images
sudo docker load -i /home/ubuntu/mysql_8.3.0.tar
sudo docker load -i /home/ubuntu/wordpress_latest.tar

# Create a Docker network
sudo docker network create wordpress_net

# Start MySQL container
sudo docker run -d --name db --network wordpress_net \
  -e MYSQL_ROOT_PASSWORD=wordpress \
  -e MYSQL_PASSWORD=wordpress \
  -e MYSQL_USER=wordpress \
  -e MYSQL_DATABASE=wordpress \
  -v db_data:/var/lib/mysql \
  mysql:8.3.0

# Start WordPress container
sudo docker run -d --name wordpress --network wordpress_net \
  -e WORDPRESS_DB_HOST=db:3306 \
  -e WORDPRESS_DB_USER=wordpress \
  -e WORDPRESS_DB_NAME=wordpress \
  -e WORDPRESS_DB_PASSWORD=wordpress \
  -p 8080:80 \
  wordpress:latest


#echo "Iniciar Instalação do Docker"
#sudo apt-get update
#sudo apt-get upgrade -y

#sudo apt-get install curl -y
#curl -fsSL https://get.docker.com -o get-docker.sh
#sudo sh get-docker.sh

#echo "Instalando Docker Compose"
#curl -L "https://github.com/docker/compose/releases/download/v2.5.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
#sudo chmod +x /usr/local/bin/docker-compose

#echo "Docker e Docker Compose instalados"

#sudo docker-compose -f /path/to/docker-compose.yml up -d




