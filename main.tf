terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.57.0"
    }

    #  docker = {
    #   source  = "kreuzwerker/docker"
    #   version = "3.0.2"
    # }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}


# provider "docker" {
#   host = "unix:///var/run/docker.sock"
# }

# # Pulls the image
# resource "docker_image" "ubuntu" {
#   name = "ubuntu:latest"
# }

# # Create a container
# resource "docker_container" "foo" {
#   image = docker_image.ubuntu.image_id
#   name  = "foo"
# }
