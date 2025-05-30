###🚀 Auto-Instalador Docker Swarm + Traefik + Portainer
Automatize a configuração do seu ambiente Docker Swarm com um único script! Este projeto facilita a instalação do Docker Swarm, configuração de rede, Traefik e Portainer, reduzindo o tempo de deploy e garantindo um setup otimizado.

📌 Pré-requisitos
Antes de começar, certifique-se de estar utilizando um sistema Linux compatível com Docker Swarm.
🛠️ Passo a passo para instalação
Siga os passos abaixo para configurar seu ambiente automaticamente.
1️⃣ Instale o Git
Se ainda não tem o Git instalado, execute o seguinte comando no terminal:

```bash
apt install git -y
```

2️⃣ Faça o clone do repositório
Baixe o script diretamente do nosso repositório no GitHub:

```bash
git clone https://github.com/inovaboost/Auto-instalador-docker.git
```

3️⃣ Acesse a pasta do script
Entre na pasta do repositório para poder executar os arquivos:

```bash
cd Auto-instalador-docker
```

4️⃣ Dê permissão de execução ao script
Antes de rodá-lo, é necessário garantir que o arquivo tenha permissões para execução:

```bash
chmod +x install_docker_swarm.sh
```

5️⃣ Execute o script de instalação
Agora, basta rodar o comando abaixo para iniciar a instalação:

```bash
./install_docker_swarm.sh
```

🔍 O que este script faz?
✅ Instalação automática do Docker Swarm
✅ Criação de rede overlay personalizada
✅ Configuração do Traefik com suporte a SSL via Let's Encrypt
✅ Deploy automático do Portainer para gerenciamento do Docker
✅ Geração dinâmica de arquivos traefik.yaml e portainer.yaml

📢 Atenção
- Durante a execução, o script pedirá algumas informações, como nome da rede, e-mail para SSL, e domínio do Portainer. Certifique-se de fornecer corretamente esses dados!
- Após o término da instalação, aguarde cerca de 30 segundos antes de acessar o Portainer pelo navegador.
🔗 Acesse o Portainer usando o domínio que você configurou durante a instalação!

💡 Dúvidas ou sugestões?
Contribua com o projeto no GitHub ou entre em contato! 🚀

Esse formato torna as instruções mais organizadas e atrativas, facilitando a compreensão dos usuários que acessarem o repositório. 🎯
Se precisar de mais ajustes ou adicionar detalhes extras, me avise! 🔧🚀
