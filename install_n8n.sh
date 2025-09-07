#!/bin/bash

set -e  # Interrompe a execução em caso de erro
set -x  # Mostra cada comando antes de ser executado

# Solicita o nome da rede já existente

read -r -p "Digite o nome da rede pública existente: " NETWORK_NAME

# Solicita domínio para o n8n
read -r -p "Digite o domínio para o n8n: " N8N_DOMAIN

# Solicita credenciais básicas
read -r -p "Digite o usuário para o n8n (auth básica): " N8N_USER
read -r -s -p "Digite a senha para o n8n (auth básica): " N8N_PASSWORD

read -p "Digite o nome da rede pública existente: " NETWORK_NAME

# Solicita domínio para o n8n
read -p "Digite o domínio para o n8n: " N8N_DOMAIN

# Solicita credenciais básicas
read -p "Digite o usuário para o n8n (auth básica): " N8N_USER
read -s -p "Digite a senha para o n8n (auth básica): " N8N_PASSWORD

echo

echo "Criando arquivo n8n.yaml..."
cat <<EOT > n8n.yaml
version: "3.7"

services:
  n8n:
    image: n8nio/n8n:latest
    environment:
      - N8N_BASIC_AUTH_ACTIVE=true
      - N8N_BASIC_AUTH_USER=$N8N_USER
      - N8N_BASIC_AUTH_PASSWORD=$N8N_PASSWORD
      - N8N_HOST=$N8N_DOMAIN
      - N8N_PORT=5678
      - N8N_PROTOCOL=https
      - WEBHOOK_URL=https://$N8N_DOMAIN/
    volumes:
      - n8n_data:/home/node/.n8n
    networks:
      - $NETWORK_NAME
    deploy:
      mode: replicated
      replicas: 1
      placement:
        constraints: [node.role == manager]
      labels:
        - "traefik.enable=true"

        - "traefik.swarm.network=$NETWORK_NAME"

        - "traefik.docker.network=$NETWORK_NAME"

        - "traefik.http.routers.n8n.rule=Host(\`$N8N_DOMAIN\`)"
        - "traefik.http.routers.n8n.entrypoints=websecure"
        - "traefik.http.routers.n8n.tls.certresolver=letsencryptresolver"
        - "traefik.http.services.n8n.loadbalancer.server.port=5678"

networks:
  $NETWORK_NAME:
    external: true

volumes:
  n8n_data:
    external: false
    name: n8n_data
EOT

# Verificando se o Traefik está rodando antes de iniciar o deploy do n8n
if docker service ls | grep -q "traefik_traefik"; then
    echo "Traefik está rodando. Continuando com o deploy do n8n..."
else
    echo "Erro: O Traefik ainda não está rodando! Aguarde e tente novamente."
    exit 1
fi

# Deploy do n8n
print_deploy_msg() {
    echo "Fazendo deploy do n8n..."
}
print_deploy_msg
docker stack deploy --prune --resolve-image always -c n8n.yaml n8n || { echo "Erro ao fazer deploy do n8n"; exit 1; }

echo "✅ n8n implantado! Acesse: https://$N8N_DOMAIN"
