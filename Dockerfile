 FROM node:18-bullseye

# Instalar texlive y utilidades necesarias
RUN apt-get update && \
    apt-get install -y \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-fonts-recommended \
    libx11-dev \
    libglu1-mesa \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Verifica pdflatex
RUN pdflatex --version

# Instalar n8n
RUN npm install -g n8n

# Crear usuario para n8n
RUN useradd --user-group --create-home --shell /bin/false n8n

# Crear carpeta y asignar permisos
RUN mkdir -p /home/n8n/.n8n && chown -R n8n:n8n /home/n8n

# Cambiar a usuario n8n
USER n8n

# Directorio de trabajo
WORKDIR /home/n8n

# Puerto por defecto
ENV PORT=5678

# Ejecutar n8n
CMD ["n8n"]
