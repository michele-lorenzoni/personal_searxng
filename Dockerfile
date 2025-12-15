FROM searxng/searxng:latest

# Build timestamp
# 2025-12-15-22-10

COPY settings.yml /etc/searxng/settings.yml
COPY templates/simple/results.html /usr/local/searxng/searx/templates/simple/results.html
COPY static/themes/simple/custom.css /usr/local/searxng/searx/static/themes/simple/custom.css

USER root

RUN echo "==== VERIFICA FILE ====" && \
    ls -lh /usr/local/searxng/searx/templates/simple/results.html && \
    cat /usr/local/searxng/searx/templates/simple/results.html | head -30 && \
    echo "==== FINE ===="

RUN chown -R searxng:searxng /etc/searxng/settings.yml

USER searxng
