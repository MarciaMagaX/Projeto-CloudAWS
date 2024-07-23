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


# Projeto de Deploy de WordPress com MySQL na AWS usando Docker e Terraform

## Descrição

Este projeto utiliza Terraform para provisionar uma instância EC2 na AWS que executa contêineres Docker para WordPress e MySQL. Inclui Dockerfiles personalizados para ambos os serviços.

## Estrutura do Projeto

/projeto
|-- Dockerfile-mysql
|-- Dockerfile-wordpress
|-- docker-compose.yml
|-- init.sql
|-- main.tf
|-- README.md


## Passos para Configuração e Deploy

### 1. Configurar o Terraform

1. Configure suas credenciais AWS.
2. Inicialize o Terraform:

```sh
terraform init

Planeje a infraestrutura:
terraform plan

Aplique a configuração:
terraform apply

Configurar Docker e Docker Compose
Conecte-se à instância EC2 provisionada.
Verifique se o Docker e o Docker Compose estão instalados.
Navegue até o diretório do projeto.
Construa e inicie os contêineres:
docker-compose build
docker-compose up -d


Acessar o WordPress
Abra seu navegador e acesse http://<IP_DA_INSTÂNCIA>:8080 para finalizar a configuração do WordPress.

Contribuindo
Faça um fork do repositório.
Crie uma nova branch: git checkout -b minha-nova-feature.
Faça suas alterações e confirme-as: git commit -m 'Adicionar nova feature'.
Envie para a branch original: git push origin minha-nova-feature.
Abra um pull request.

Licença
Este projeto está licenciado sob a Licença MIT. Veja o arquivo LICENSE para mais detalhes.


Este README.md fornece uma visão clara e abrangente do projeto, facilitando para qualquer pessoa entender a estrutura, seguir os passos de configuração e deploy, e contribuir para o projeto.
