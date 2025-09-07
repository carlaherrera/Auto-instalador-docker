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
<br>
🔍 O que este script faz?
<br>✅ Instalação automática do Docker Swarm
<br>✅ Criação de rede overlay personalizada
<br>✅ Configuração do Traefik com suporte a SSL via Let's Encrypt
<br>✅ Deploy automático do Portainer para gerenciamento do Docker
<br>✅ Geração dinâmica de arquivos traefik.yaml e portainer.yaml

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

