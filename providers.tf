
# This block of code is uded to denote the source of docker
terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

#This is to mention that we are running docker locally
# provider "docker" {}