FROM n8nio/n8n:latest

USER root

# Instala Python e dependências de sistema para Debian
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-venv \
    build-essential \
    libfreetype6-dev \
    libpng-dev \
    libopenblas-dev \
    && rm -rf /var/lib/apt/lists/*

# Cria ambiente virtual
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Instala bibliotecas
RUN pip install --upgrade pip
RUN pip install --no-cache-dir --default-timeout=100 requests fpdf2 matplotlib

# Dá permissão para o usuário node
RUN chown -R node:node /opt/venv

USER node
