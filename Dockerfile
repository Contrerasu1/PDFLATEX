FROM n8nio/n8n:latest-debian

ENV DEBIAN_FRONTEND=noninteractive

USER root
RUN apt-get update && \
    apt-get install -y texlive-latex-base texlive-fonts-recommended \
    texlive-latex-recommended texlive-latex-extra && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER node

ENV N8N_BASIC_AUTH_ACTIVE=true \
    N8N_BASIC_AUTH_USER=admin \
    N8N_BASIC_AUTH_PASSWORD=admin123 \
    N8N_HOST=0.0.0.0 \
    N8N_PORT=5678 \
    NODE_ENV=production

EXPOSE 5678

CMD ["tini", "--", "n8n"]
