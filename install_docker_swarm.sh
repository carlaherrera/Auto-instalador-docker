#!/bin/bash

# Atualizando pacotes e instalando dependências
echo "Atualizando pacotes..."
sudo apt-get update ; apt-get install -y apparmor-utils

# Instalando o Docker
echo "Instalando Docker..."
curl -fsSL https://get.docker.com | bash

# Adicionando usuário ao grupo docker
sudo usermod -aG docker $USER
newgrp docker

# Inicializando o Docker Swarm
echo "Inicializando Docker Swarm..."
docker swarm init

# Solicita o nome da rede ao usuário
read -p "Digite o nome da rede interna: " NETWORK_NAME

# Criando a rede overlay
echo "Criando rede overlay..."
docker network create --driver=overlay "$NETWORK_NAME"

# Criando traefik.yaml
echo "Criando arquivo traefik.yaml..."
cat <<EOF > traefik.yaml
version: "3.7"

services:
  traefik:
    image: traefik:2.11.2
    command:
      - "--api.dashboard=true"
      - "--providers.docker.swarmMode=true"
      - "--providers.docker.network=$NETWORK_NAME"
      - "--entrypoints.web.address=:80"
      - "--entrypoints.websecure.address=:443"
EOF

# Solicita o e-mail do usuário para certificados SSL
read -p "Digite seu e-mail para SSL (Let's Encrypt): " USER_EMAIL

# Adiciona o e-mail ao arquivo traefik.yaml
sed -i "/entrypoints.websecure.address/a \      - \"--certificatesresolvers.letsencryptresolver.acme.email=$USER_EMAIL\"" traefik.yaml

# Deploy do Traefik
echo "Fazendo deploy do Traefik..."
docker stack deploy --prune --resolve-image always -c traefik.yaml traefik

# Criando portainer.yaml
echo "Criando arquivo portainer.yaml..."
cat <<EOF > portainer.yaml
version: "3.7"

services:
  agent:
    image: portainer/agent:2.20.1
    networks:
      - $NETWORK_NAME

  portainer:
    image: portainer/portainer-ce:2.20.1
    networks:
      - $NETWORK_NAME
EOF

# Solicita domínio ao usuário
read -p "Digite seu domínio para acesso ao Portainer: " USER_DOMAIN

# Adiciona o domínio ao arquivo portainer.yaml
sed -i "/portainer/a \        - \"traefik.http.routers.portainer.rule=Host(\`$USER_DOMAIN\`)\"" portainer.yaml

# Deploy do Portainer
echo "Fazendo deploy do Portainer..."
docker stack deploy --prune --resolve-image always -c portainer.yaml portainer

# Mensagem final
echo "Instalação concluída! Aguarde 30 segundos antes de acessar o Portainer."
echo "Acesse: https://$USER_DOMAIN"
