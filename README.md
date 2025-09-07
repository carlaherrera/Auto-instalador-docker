
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

###🚀 Auto-Instalador Docker Swarm + Traefik + Portainer + n8n + Evolution API
Automatize a configuração do seu ambiente Docker Swarm com um único script! Este projeto facilita a instalação do Docker Swarm, configuração de rede, Traefik, Portainer, n8n e Evolution API, reduzindo o tempo de deploy e garantindo um setup otimizado. Agora utiliza as versões mais recentes das ferramentas, incluindo **Traefik 3.5.1**, **Portainer CE 2.33.1** e **Evolution API (latest)**.

###🚀 Auto-Instalador Docker Swarm + Traefik + Portainer + n8n
Automatize a configuração do seu ambiente Docker Swarm com um único script! Este projeto facilita a instalação do Docker Swarm, configuração de rede, Traefik, Portainer e n8n, reduzindo o tempo de deploy e garantindo um setup otimizado. Agora utiliza as versões mais recentes das ferramentas, incluindo **Traefik 3.5.1** e **Portainer CE 2.33.1**.
###🚀 Auto-Instalador Docker Swarm + Traefik + Portainer
Automatize a configuração do seu ambiente Docker Swarm com um único script! Este projeto facilita a instalação do Docker Swarm, configuração de rede, Traefik e Portainer, reduzindo o tempo de deploy e garantindo um setup otimizado. Agora utiliza as versões mais recentes das ferramentas, incluindo **Traefik 3.5.1** e **Portainer CE 2.33.1**.


<br>
📌 Pré-requisitos
Antes de começar, certifique-se de estar utilizando um sistema Linux compatível com Docker Swarm.

<br>
🛠️ Passo a passo para instalação
Siga os passos abaixo para configurar seu ambiente automaticamente.

<br>
<br>
1️⃣ Instale o Git
Se ainda não tem o Git instalado, execute o seguinte comando no terminal:

```bash
apt install git -y
```

<br>
2️⃣ Faça o clone do repositório
Baixe o script diretamente do nosso repositório no GitHub:

```bash
git clone https://github.com/carlaherrera/Auto-instalador-docker.git
```

<br>
3️⃣ Acesse a pasta do script
Entre na pasta do repositório para poder executar os arquivos:

```bash
cd Auto-instalador-docker
```

<br>
4️⃣ Dê permissão de execução ao script
Antes de rodá-lo, é necessário garantir que o arquivo tenha permissões para execução:

```bash
chmod +x install_docker_swarm.sh
```

<br>
5️⃣ Execute o script de instalação
Agora, basta rodar o comando abaixo para iniciar a instalação:

```bash
./install_docker_swarm.sh
```

<br>
6️⃣ (Opcional) Instale o n8n
Se desejar utilizar o n8n, execute o script abaixo após concluir a instalação anterior:

```bash
chmod +x install_n8n.sh
./install_n8n.sh
```


7️⃣ (Opcional) Instale o Evolution API
Se desejar utilizar o Evolution API, execute o script abaixo após concluir a instalação anterior:

```bash
chmod +x install_evolution_api.sh
./install_evolution_api.sh
```



<br>
<br>
🔍 O que este script faz?
<br>✅ Instalação automática do Docker Swarm
<br>✅ Criação de rede overlay personalizada
<br>✅ Configuração do Traefik 3 (provider Swarm) com suporte a SSL via Let's Encrypt
<br>✅ Deploy automático do Portainer para gerenciamento do Docker
<br>✅ Geração dinâmica de arquivos traefik.yaml e portainer.yaml
<br>✅ Deploy opcional do n8n integrado ao Traefik

<<br>✅ Deploy opcional do Evolution API integrado ao Traefik



<br>
<br>
📢 Atenção
- Durante a execução, o script pedirá algumas informações, como nome da rede, e-mail para SSL, e domínio do Portainer. Certifique-se de fornecer corretamente esses dados!
- Após o término da instalação, aguarde cerca de 30 segundos antes de acessar o Portainer pelo navegador.
🔗 Acesse o Portainer usando o domínio que você configurou durante a instalação!

<br>
<br>
💡 Dúvidas ou sugestões?
Contribua com o projeto no GitHub ou entre em contato! 🚀

