FROM n8nio/n8n:latest

USER root

# 1. Instalar Python e dependências do sistema
RUN apk add --update --no-cache python3 py3-pip build-base freetype-dev libpng-dev openblas-dev

# 2. Configurar ambiente virtual no local padrão
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# 3. Instalar bibliotecas Python
RUN pip install --upgrade pip
RUN pip install fpdf2 matplotlib requests

# 4. CRUCIAL: Dar permissão para o usuário 'node' usar essa pasta
RUN chown -R node:node /opt/venv

USER node
