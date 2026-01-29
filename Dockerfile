# Usa a imagem oficial do n8n como base
FROM n8nio/n8n:latest

# Muda para usuário root para poder instalar programas
USER root

# 1. Instala Python 3 e gerenciador de pacotes pip
# (Como a base é Alpine Linux, usamos apk)
RUN apk add --update --no-cache python3 py3-pip build-base freetype-dev libpng-dev openblas-dev

# 2. Configura um ambiente virtual para o Python (Boas práticas do Alpine)
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# 3. Atualiza o pip e instala as bibliotecas necessárias para o seu relatório
RUN pip install --upgrade pip
RUN pip install fpdf2 matplotlib requests

# 4. Volta para o usuário padrão do n8n para segurança
USER node
