FROM n8nio/n8n:latest

USER root

# Instala Python e dependências de sistema
RUN apk add --update --no-cache python3 py3-pip build-base freetype-dev libpng-dev openblas-dev

# Cria ambiente virtual
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Instala bibliotecas
# MELHORIA: Aumentamos o timeout e usamos --no-cache-dir para economizar RAM e disco
RUN pip install --upgrade pip
RUN pip install --no-cache-dir --default-timeout=100 requests fpdf2
# Separamos o matplotlib pois ele é o mais pesado e propenso a falhas
RUN pip install --no-cache-dir --default-timeout=100 matplotlib

# DÁ PERMISSÃO
RUN chown -R node:node /opt/venv

USER node
