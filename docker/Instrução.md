### 1. Remova versões antigas do Docker (se existirem):

```bash
sudo apt remove docker docker-engine docker.io containerd runc
```

### 2. Atualize o índice de pacotes:

```bash
sudo apt update
```

### 3. Instale as dependências necessárias para permitir que o apt use repositórios HTTPS:

```bash
sudo apt install apt-transport-https ca-certificates curl software-properties-common
```

### 4. Adicione a chave GPG oficial do Docker:

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

### 5. Adicione o repositório Docker ao sistema:

```bash
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

### 6. Atualize novamente o índice de pacotes:

```bash
sudo apt update
```

### 7. Instale a versão mais recente do Docker Engine:

```bash
sudo apt install docker-ce docker-ce-cli containerd.io
```

### 8. Adicione seu usuário ao grupo `docker` para evitar a necessidade de usar `sudo`:

```bash
sudo usermod -aG docker $USER
```

### 9. Faça logout e login novamente para aplicar as alterações.

### 10. Verifique se a instalação foi bem-sucedida executando o comando abaixo. Isso deve imprimir informações sobre a versão do Docker instalada:

```bash
docker --version
```

### 11. Execute um contêiner de teste para verificar se o Docker está funcionando corretamente:

```bash
docker run hello-world
```

Essas instruções devem ajudar você a instalar o Docker no Ubuntu 22.04 LTS. Lembre-se de que essas instruções podem ser atualizadas conforme novas versões do Docker e do Ubuntu são lançadas. Sempre verifique a documentação oficial para obter as instruções mais recentes.
