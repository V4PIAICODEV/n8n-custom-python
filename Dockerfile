# USAR ESTA IMAGEM É O SEGREDO
# A versão debian permite instalar pandas/numpy sem compilar do zero
FROM n8nio/n8n:latest-debian

USER root

# 1. Instalar Python e dependências básicas do sistema
# O 'venv' é necessário no Debian para criar ambientes virtuais
RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv build-essential python3-dev && \
    apt-get clean

# 2. Criar e configurar o ambiente virtual
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# 3. Atualizar pip e instalar bibliotecas pesadas
# A flag --no-cache-dir ajuda a evitar erros de disco cheio
RUN pip install --upgrade pip --no-cache-dir
RUN pip install --no-cache-dir fpdf2 matplotlib requests pandas numpy

# 4. Ajustar permissões para o usuário do n8n
RUN chown -R node:node /opt/venv

USER node
