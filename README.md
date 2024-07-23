# Projeto-Minsait

Este projeto tem como objetivo:
1) criar uma VM
2) instalar docker utilizando um script de inicialização
3) subir um container com o WordPress instalado na VM
4) configurar containers separados para o WordPress e o banco de dados, garantindo a retenção de dados durante o upgrade da aplicação
5) fornecer um arquivo docker-compose.yml para facilitar a criação dos containers
6) configurar senha do usuário root do banco de dados 

# Terraform AWS WordPress Deployment

Este projeto utiliza o Terraform para criar uma instância AWS e configurar um ambiente WordPress usando Docker Compose. 

## Pré-requisitos

Antes de começar, certifique-se de ter os seguintes pré-requisitos instalados:

- [Terraform](https://www.terraform.io/downloads.html)
- [AWS CLI](https://aws.amazon.com/cli/)
- Uma conta AWS com permissões suficientes para criar instâncias e grupos de segurança

## Configuração

### 1. Arquivo `main.tf`

O arquivo `main.tf` contém a definição dos recursos AWS e a configuração necessária para iniciar uma instância EC2 com Docker e Docker Compose instalados.

```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "amb-prod14" {
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

# Cria o arquivo docker-compose.yml
cat << 'EOT' > docker-compose.yml
version: '3.8'

services:
  db:
    image: mysql:8.0
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: GAud4mZby8F3SD6P
      MYSQL_PASSWORD: GAud4mZby8F3SD6P
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
      WORDPRESS_DB_PASSWORD: GAud4mZby8F3SD6P
    ports:
      - "8080:80"
    networks:
      - wordpress_net

volumes:
  db_data:

networks:
  wordpress_net:
EOT

# Atualiza os pacotes e instala o Docker
sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

# Adiciona o usuário 'ubuntu' ao grupo 'docker'
sudo usermod -aG docker ubuntu

# Instala o Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Executa o Docker Compose
sudo -u ubuntu docker-compose up -d
EOF

  tags = {
    Name = "amb-prod14"
  }
}

resource "aws_security_group" "allow_ssh" {
  name_prefix = "allow_ssh"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_http" {
  name_prefix = "allow_http"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_https" {
  name_prefix = "allow_https"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


Como Usar
Passo 1: Configurar Credenciais AWS
Certifique-se de que suas credenciais AWS estejam configuradas. Você pode configurar suas credenciais usando o AWS CLI:
aws configure

Passo 2: Inicializar o Terraform
No diretório onde seu arquivo main.tf está localizado, inicialize o Terraform:
terraform init

Passo 3: Planejar a Execução
Crie um plano de execução para verificar os recursos que serão criados:
terraform plan

Passo 4: Aplicar o Plano
Aplique o plano para criar os recursos na AWS:
terraform apply

Digite yes quando solicitado para confirmar a aplicação.

Limpeza
Para destruir os recursos criados pelo Terraform, execute:
terraform destroy

Digite yes quando solicitado para confirmar a destruição.

Contribuição
Se você quiser contribuir para este projeto, sinta-se à vontade para abrir issues e enviar pull requests.

Licença
Este projeto é licenciado sob a MIT License.


Este `README.md` fornece uma visão geral clara e estruturada do projeto, incluindo instruções sobre como configurar, usar e limpar os recursos criados pelo Terraform, com a adição dos grupos de segurança.
