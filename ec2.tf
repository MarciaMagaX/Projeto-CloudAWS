resource "aws_instance" "amb-prod" {
  ami           = "ami-0a0e5d9c7acc336f1" # Substitua pelo ID da AMI que deseja usar
  instance_type = "t2.micro"
  key_name      = "Terraform"
  
  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id,
    aws_security_group.allow_https.id,
    aws_security_group.allow_http.id
  ]

  user_data = <<-EOF
              #!/bin/bash
              echo "Instalando Docker"
              curl -fsSL https://get.docker.com -o get-docker.sh
              sh get-docker.sh
              echo "Docker instalado"
              echo "Instalando Docker Compose"
              curl -L "https://github.com/docker/compose/releases/download/v2.5.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
              chmod +x /usr/local/bin/docker-compose
              echo "Docker Compose instalado"

              # Adicionando o usuário atual ao grupo docker
              usermod -aG docker ubuntu
              newgrp docker

              echo "Copiando docker-compose.yml"
              cp /home/ubuntu/docker-compose.yml /home/ubuntu/docker-compose.yml

              cd /home/ubuntu
              docker-compose up -d
            EOF

  tags = {
    Name = "amb-prod"
  }
}






