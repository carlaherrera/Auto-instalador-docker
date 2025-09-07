#!/bin/bash

set -e  # Interrompe a execução em caso de erro
set -x  # Mostra cada comando antes de ser executado

# Solicita o nome da rede já existente
read -r -p "Digite o nome da rede pública existente: " NETWORK_NAME

# Solicita domínio para o Evolution API
read -r -p "Digite o domínio para o Evolution API: " EVO_DOMAIN

# Solicita credenciais para o banco de dados PostgreSQL
read -r -p "Digite o usuário do banco de dados: " POSTGRES_USER
read -r -s -p "Digite a senha do banco de dados: " POSTGRES_PASSWORD
echo
read -r -p "Digite o nome do banco de dados: " POSTGRES_DB

echo "Criando arquivo evolution.yaml..."
cat <<EOT > evolution.yaml
version: "3.8"

services:
  api:
    image: evoapicloud/evolution-api:latest
    environment:
      - SERVER_TYPE=https
      - SERVER_PORT=8080
      - SERVER_URL=https://$EVO_DOMAIN
      - DATABASE_PROVIDER=postgresql
      - DATABASE_CONNECTION_URI=postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@postgres:5432/$POSTGRES_DB?schema=evolution_api
      - POSTGRES_DATABASE=$POSTGRES_DB
      - POSTGRES_USERNAME=$POSTGRES_USER
      - POSTGRES_PASSWORD=$POSTGRES_PASSWORD
    volumes:
      - evolution_instances:/evolution/instances
    networks:
      - $NETWORK_NAME
    depends_on:
      - redis
      - postgres
    deploy:
      mode: replicated
      replicas: 1
      placement:
        constraints: [node.role == manager]
      labels:
        - "traefik.enable=true"
        - "traefik.swarm.network=$NETWORK_NAME"
        - "traefik.http.routers.evolution.rule=Host(\`$EVO_DOMAIN\`)"
        - "traefik.http.routers.evolution.entrypoints=websecure"
        - "traefik.http.routers.evolution.tls.certresolver=letsencryptresolver"
        - "traefik.http.services.evolution.loadbalancer.server.port=8080"

  redis:
    image: redis:latest
    volumes:
      - evolution_redis:/data
    networks:
      - $NETWORK_NAME

  postgres:
    image: postgres:latest
    environment:
      - POSTGRES_DB=$POSTGRES_DB
      - POSTGRES_USER=$POSTGRES_USER
      - POSTGRES_PASSWORD=$POSTGRES_PASSWORD
    volumes:
      - postgres_data:/var/lib/postgresql/data
    networks:
      - $NETWORK_NAME

networks:
  $NETWORK_NAME:
    external: true

volumes:
  evolution_instances:
  evolution_redis:
  postgres_data:
EOT

# Verificando se o Traefik está rodando antes de iniciar o deploy do Evolution API
if docker service ls | grep -q "traefik_traefik"; then
    echo "Traefik está rodando. Continuando com o deploy do Evolution API..."
else
    echo "Erro: O Traefik ainda não está rodando! Aguarde e tente novamente."
    exit 1
fi

# Deploy do Evolution API
print_deploy_msg() {
    echo "Fazendo deploy do Evolution API..."
}
print_deploy_msg
docker stack deploy --prune --resolve-image always -c evolution.yaml evolution || { echo "Erro ao fazer deploy do Evolution API"; exit 1; }

echo "✅ Evolution API implantado! Acesse: https://$EVO_DOMAIN"
