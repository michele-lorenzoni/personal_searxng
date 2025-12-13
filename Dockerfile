FROM searxng/searxng:latest
COPY settings.yml /etc/searxng/settings.yml
USER root
RUN chown -R searxng:searxng /etc/searxng/settings.yml
USER searxng
