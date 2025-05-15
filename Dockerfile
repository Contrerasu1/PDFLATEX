FROM node:18-bullseye

ENV DEBIAN_FRONTEND=noninteractive

# Instalar pdflatex (TeX Live) y utilidades necesarias
RUN apt-get update && \
    apt-get install -y texlive-latex-base texlive-latex-extra texlive-fonts-recommended \
    libx11-dev libglu1-mesa && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Instalar n8n globalmente
RUN npm install -g n8n

# Crear usuario n8n
RUN useradd --user-group --create-home --shell /bin/false n8n
ENV N8N_USER=n8n

# Crear carpetas de trabajo
RUN mkdir -p /home/n8n/.n8n && chown -R n8n:n8n /home/n8n

# Establecer usuario no root
USER n8n

# Variables de entorno
ENV N8N_BASIC_AUTH_ACTIVE=true \
    N8N_BASIC_AUTH_USER=admin \
    N8N_BASIC_AUTH_PASSWORD=admin123 \
    N8N_PORT=5678 \
    N8N_HOST=0.0.0.0 \
    NODE_ENV=production

EXPOSE 5678

CMD ["n8n"]
