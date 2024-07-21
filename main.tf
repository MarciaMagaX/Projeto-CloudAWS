provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "amb-prod3" {
  ami           = "ami-0a0e5d9c7acc336f1"  # Escolha uma AMI compatível com Ubuntu
  instance_type = "t2.micro"
  key_name      = "terraform2"  # Substitua pelo nome do seu par de chaves

  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id,
    aws_security_group.allow_https.id,
    aws_security_group.allow_http.id
  ]


  # User data to install Docker and run the containers
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y docker.io
              sudo systemctl start docker
              sudo systemctl enable docker
              sudo docker pull mysql:8.0
              sudo docker pull wordpress:latest
              sudo docker network create wordpress_net
              sudo docker run -d --name db --network wordpress_net \
                -e MYSQL_ROOT_PASSWORD=wordpress \
                -e MYSQL_PASSWORD=wordpress \
                -e MYSQL_USER=wordpress \
                -e MYSQL_DATABASE=wordpress \
                -v db_data:/var/lib/mysql \
                mysql:8.0
              sudo docker run -d --name wordpress --network wordpress_net \
                -e WORDPRESS_DB_HOST=db:3306 \
                -e WORDPRESS_DB_USER=wordpress \
                -e WORDPRESS_DB_NAME=wordpress \
                -e WORDPRESS_DB_PASSWORD=wordpress \
                -p 8080:80 \
                wordpress:latest
              EOF

  tags = {
    Name = "amb-prod3"
  }
}

