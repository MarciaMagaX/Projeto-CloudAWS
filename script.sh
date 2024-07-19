#!/bin/bash

echo "Iniciar Instalação do Docker"
sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install curl -y
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

echo "Instalando Docker Compose"
curl -L "https://github.com/docker/compose/releases/download/v2.5.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "Docker e Docker Compose instalados"

sudo docker-compose -f /path/to/docker-compose.yml up -d




