# Forçamos o uso da versão alpine para garantir que o 'apk' exista
FROM n8nio/n8n:latest-alpine

USER root

# Instala Python e dependências para gráficos/PDF
RUN apk add --update --no-cache \
    python3 \
    py3-pip \
    build-base \
    freetype-dev \
    libpng-dev \
    openblas-dev \
    libstdc++

# Cria um ambiente virtual para evitar erros de "externally managed environment"
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Instala as bibliotecas necessárias
RUN pip install --upgrade pip
RUN pip install --no-cache-dir requests fpdf2 matplotlib

# Permissões para o usuário padrão do n8n
RUN chown -R node:node /opt/venv

USER node
