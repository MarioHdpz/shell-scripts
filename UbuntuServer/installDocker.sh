#!/bin/sh
# Installs Docker in Ubuntu 20.04 - amd64
# Installs docker compose v2

DOCKER_COMPOSE_VERSION="v2.0.0-rc.1"

sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update
sudo apt install docker-ce -y
sudo usermod -aG docker ${USER}

mkdir -p ${HOME}/.docker/cli-plugins/
curl -SL https://github.com/docker/compose-cli/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-linux-amd64 -o ~/.docker/cli-plugins/docker-compose
chmod +x ${HOME}/.docker/cli-plugins/docker-compose
