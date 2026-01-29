FROM n8nio/n8n:latest

USER root

# --- CORREÇÃO: Restaurar o 'apk' que foi removido do n8n ---
COPY --from=alpine:3.20 /sbin/apk /sbin/apk
COPY --from=alpine:3.20 /lib/libapk.so* /lib/
COPY --from=alpine:3.20 /usr/share/apk /usr/share/apk
COPY --from=alpine:3.20 /etc/apk /etc/apk
# -----------------------------------------------------------

# 1. Instalar Python e dependências
# (Adicionei linux-headers e cargo para ajudar a compilar o pandas no Alpine)
RUN apk add --update --no-cache \
    python3 py3-pip build-base freetype-dev libpng-dev openblas-dev \
    python3-dev libffi-dev linux-headers cargo

# 2. Configurar ambiente virtual
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# 3. Instalar bibliotecas
RUN pip install --upgrade pip
# Nota: Pandas no Alpine pode demorar 10min+ para compilar.
RUN pip install fpdf2 matplotlib requests pandas numpy

# 4. Permissões
RUN chown -R node:node /opt/venv

USER node
