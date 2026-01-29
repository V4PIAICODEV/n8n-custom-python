FROM n8nio/n8n:latest-debian

USER root

# CORREÇÃO: Apontar repositórios do Buster para o Archive (pois ele morreu)
RUN echo "deb http://archive.debian.org/debian buster main" > /etc/apt/sources.list && \
    echo "deb http://archive.debian.org/debian-security buster/updates main" >> /etc/apt/sources.list && \
    echo "Acquire::Check-Valid-Until false;" > /etc/apt/apt.conf.d/99no-check-valid-until

# Agora o update vai funcionar
RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv build-essential python3-dev && \
    apt-get clean

ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN pip install --upgrade pip --no-cache-dir
RUN pip install --no-cache-dir fpdf2 matplotlib requests pandas numpy

RUN chown -R node:node /opt/venv

USER node
