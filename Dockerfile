FROM n8nio/n8n:latest

USER root

# Instala Python
RUN apk add --update --no-cache python3 py3-pip build-base freetype-dev libpng-dev openblas-dev

# Cria ambiente virtual
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Instala bibliotecas
RUN pip install --upgrade pip
RUN pip install fpdf2 matplotlib requests

# DÁ PERMISSÃO (Se isso faltar, o n8n não consegue ler o Python)
RUN chown -R node:node /opt/venv

USER node
