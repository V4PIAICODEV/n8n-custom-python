FROM n8nio/n8n:latest-alpine

USER root

# Instala Python e dependências de compilação necessárias para Matplotlib no Alpine
RUN apk add --update --no-cache \
    python3 \
    python3-dev \
    py3-pip \
    build-base \
    freetype-dev \
    libpng-dev \
    openblas-dev \
    libstdc++

# Cria e configura o ambiente virtual
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Instala as bibliotecas Python
RUN pip install --upgrade pip
RUN pip install --no-cache-dir requests fpdf2 matplotlib

# Garante que o usuário do n8n possa acessar o ambiente virtual
RUN chown -R node:node /opt/venv

USER node
