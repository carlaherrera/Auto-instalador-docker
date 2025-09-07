# 🚀 Auto-Instalador Docker Swarm + Traefik + Portainer + n8n + Evolution API

Automatize a configuração do seu ambiente Docker Swarm com um único script! Este projeto instala e integra **Traefik 3.5.1**, **Portainer CE 2.33.1**, **n8n** e **Evolution API (latest)** utilizando sempre as imagens mais recentes.

## 📌 Pré-requisitos
- Sistema Linux compatível com Docker
- Acesso root ou sudo

## 🛠️ Passo a passo
1. **Instale o Git**
   ```bash
   apt install git -y
   ```
2. **Clone o repositório e acesse a pasta**
   ```bash
   git clone https://github.com/inovaboost/Auto-instalador-docker.git
   cd Auto-instalador-docker
   ```
3. **Dê permissão de execução aos scripts**
   ```bash
   chmod +x install_docker_swarm.sh install_n8n.sh install_evolution_api.sh
   ```
4. **Execute o instalador principal**
   ```bash
   ./install_docker_swarm.sh
   ```
5. **(Opcional) Instale o n8n**
   ```bash
   ./install_n8n.sh
   ```
6. **(Opcional) Instale o Evolution API**
   ```bash
   ./install_evolution_api.sh
   ```

## 🔍 O que este instalador faz?
- Instalação automática do Docker Swarm
- Criação de rede overlay personalizada
- Configuração do Traefik 3 (Swarm provider) com Let's Encrypt
- Deploy do Portainer para gerenciamento
- Deploy opcional do n8n e Evolution API integrados ao Traefik

## 📢 Atenção
- Durante a execução, serão solicitados nome da rede, e-mail para SSL e domínio do Portainer. Informe-os corretamente.
- Após a instalação, aguarde ~30 segundos antes de acessar o Portainer.

💡 Contribua com o projeto no GitHub ou entre em contato para dúvidas e sugestões!
