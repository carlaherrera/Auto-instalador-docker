#!/bin/bash

set -e  # Interrompe a execução em caso de erro
set -x  # Mostra cada comando antes de ser executado

# Solicita o nome da rede já existente
read -r -p "Digite o nome da rede pública existente: " NETWORK_NAME

# Solicita credenciais e banco de dados
read -r -p "Digite o nome do banco de dados: " POSTGRES_DB
read -r -p "Digite o usuário do banco de dados: " POSTGRES_USER
read -r -s -p "Digite a senha do banco de dados: " POSTGRES_PASSWORD
echo

echo "Criando arquivo postgres.yaml..."
cat <<EOT > postgres.yaml
version: "3.8"

services:
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
    ports:
      - target: 5432
        published: 5432
        protocol: tcp
        mode: host
    deploy:
      mode: replicated
      replicas: 1
      placement:
        constraints: [node.role == manager]

networks:
  $NETWORK_NAME:
    external: true

volumes:
  postgres_data:
    external: false
    name: postgres_data
EOT

echo "Fazendo deploy do PostgreSQL..."
docker stack deploy --prune --resolve-image always -c postgres.yaml postgres || { echo "Erro ao fazer deploy do PostgreSQL"; exit 1; }

echo "✅ PostgreSQL implantado! Porta 5432 exposta."
