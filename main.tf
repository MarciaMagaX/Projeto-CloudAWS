provider "aws" {
  region = "us-east-1"
}

# Recurso para criar a instância AWS
resource "aws_instance" "amb-prod9" {
  ami           = "ami-0a0e5d9c7acc336f1"
  instance_type = "t2.micro"
  key_name      = "terraform2"

  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id,
    aws_security_group.allow_https.id,
    aws_security_group.allow_http.id
  ]

  user_data = <<-EOF
 #!/bin/bash
 touch docker-compose.yml
 
cat << 'EOT' > docker-compose.yml
version: '3.8'

services:
  db:
    image: mysql:8.0
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: wordpress
      MYSQL_PASSWORD: wordpress
      MYSQL_USER: wordpress
      MYSQL_DATABASE: wordpress
    volumes:
      - db_data:/var/lib/mysql
    networks:
      - wordpress_net

  wordpress:
    image: wordpress:latest
    restart: always
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_NAME: wordpress
      WORDPRESS_DB_PASSWORD: wordpress
    ports:
      - "8080:80"
    networks:
      - wordpress_net

volumes:
  db_data:

networks:
  wordpress_net:
EOT

sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Create directories for Docker Compose file
# mkdir -p /home/ubuntu/app

# Create Docker Compose file

# Run Docker Compose
# cd /home/ubuntu/app
sudo docker-compose up -d
EOF


  tags = {
    Name = "amb-prod9"
  }
}

