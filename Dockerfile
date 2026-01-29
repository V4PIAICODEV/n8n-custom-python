# Volta para a imagem oficial (Alpine) que é mais moderna e leve
FROM n8nio/n8n:latest

USER root

# 1. Instalar Python e as bibliotecas PESADAS via sistema (APK)
# Isso evita a compilação que causava o "Broken Pipe"
# O pacote 'python3-dev' e 'build-base' ficam para garantir compatibilidade
RUN apk add --update --no-cache \
    python3 \
    py3-pip \
    py3-pandas \
    py3-numpy \
    py3-matplotlib \
    py3-requests \
    build-base \
    python3-dev

# 2. Configurar ambiente virtual com acesso aos pacotes do sistema
ENV VIRTUAL_ENV=/opt/venv
# A flag --system-site-packages é o segredo: permite que a venv "enxergue" o Pandas instalado pelo APK
RUN python3 -m venv --system-site-packages $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# 3. Instalar bibliotecas LEVES via Pip (que não existem no APK)
RUN pip install --upgrade pip --no-cache-dir
RUN pip install --no-cache-dir fpdf2

# 4. Ajustar permissões
RUN chown -R node:node /opt/venv

USER node
