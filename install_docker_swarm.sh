#!/bin/bash

set -e  # Interrompe a execução em caso de erro
set -x  # Mostra cada comando antes de ser executado

# Atualizando pacotes e instalando dependências
echo "Atualizando pacotes..."
sudo apt update && sudo apt upgrade -y

# Instalando o Docker
echo "Verificando se o Docker já está instalado..."
if ! command -v docker &> /dev/null
then
    echo "Instalando Docker..."
    curl -fsSL https://get.docker.com | bash
else
    echo "Docker já está instalado. Pulando esta etapa..."
fi

# Adicionando usuário ao grupo docker
echo "Adicionando usuário ao grupo docker..."
sudo usermod -aG docker root

# **Removido o comando newgrp docker, para evitar interrupção do script**
echo "Reinicie a sessão ou execute 'exec su - root' para aplicar as mudanças de grupo."

# Inicializando o Docker Swarm
echo "Inicializando Docker Swarm..."
docker swarm init || { echo "Erro ao inicializar Docker Swarm"; exit 1; }

# Solicita o nome da rede ao usuário
read -p "Digite o nome da rede interna: " NETWORK_NAME

# Criando a rede overlay
echo "Criando rede overlay..."
docker network create --driver=overlay "$NETWORK_NAME" || { echo "Erro ao criar a rede"; exit 1; }

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
    deploy:
      placement:
        constraints:
          - node.role == manager
    volumes:
      - "/var/run/docker.sock:/var/run/docker.sock:ro"
      - "vol_certificates:/etc/traefik/letsencrypt"
    networks:
      - "$NETWORK_NAME"

volumes:
  vol_certificates:
    external: false

networks:
  $NETWORK_NAME:
    external: true
EOF

# Solicita o e-mail do usuário para certificados SSL
read -p "Digite seu e-mail para SSL (Let's Encrypt): " USER_EMAIL

# Adiciona o e-mail ao arquivo traefik.yaml
sed -i "/entrypoints.websecure.address/a \      - \"--certificatesresolvers.letsencryptresolver.acme.email=$USER_EMAIL\"" traefik.yaml

# Deploy do Traefik
echo "Fazendo deploy do Traefik..."
docker stack deploy --prune --resolve-image always -c traefik.yaml traefik || { echo "Erro ao fazer deploy do Traefik"; exit 1; }

# Criando portainer.yaml
echo "Criando arquivo portainer.yaml..."
cat <<EOF > portainer.yaml
version: "3.7"

services:
  agent:
    image: portainer/agent:2.20.1
    networks:
      - $NETWORK_NAME
    deploy:
      mode: global
      placement:
        constraints: [node.platform.os == linux]

  portainer:
    image: portainer/portainer-ce:2.20.1
    command: -H tcp://tasks.agent:9001 --tlsskipverify
    networks:
      - $NETWORK_NAME
    deploy:
      mode: replicated
      replicas: 1
      placement:
        constraints: [node.role == manager]
EOF

# Solicita domínio ao usuário
read -p "Digite seu domínio para acesso ao Portainer: " USER_DOMAIN

# Adiciona o domínio ao arquivo portainer.yaml
sed -i "/portainer/a \        - \"traefik.http.routers.portainer.rule=Host(\`$USER_DOMAIN\`)\"" portainer.yaml

# Deploy do Portainer
echo "Fazendo deploy do Portainer..."
docker stack deploy --prune --resolve-image always -c portainer.yaml portainer || { echo "Erro ao fazer deploy do Portainer"; exit 1; }

# Mensagem final
echo "✅ Instalação concluída! Aguarde 30 segundos antes de acessar o Portainer."
echo "🔗 Acesse: https://$USER_DOMAIN"
