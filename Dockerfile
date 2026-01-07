FROM searxng/searxng:latest
COPY settings.yml /etc/searxng/settings.yml
COPY searx/templates/static/themes/simple/highlight.css /usr/local/searxng/searx/static/themes/simple/highlight.css
COPY searx/templates/static/themes/simple/img/favicon.png /usr/local/searxng/searx/static/themes/simple/img/favicon.png
COPY searx/templates/static/themes/simple/img/favicon.svg /usr/local/searxng/searx/static/themes/simple/img/favicon.svg

USER root

# Verifica PRIMA della compressione
RUN echo "=== BEFORE compression ===" && \
    ls -lah /usr/local/searxng/searx/static/themes/simple/img/favicon.* && \
    echo "=== First 5 lines of custom SVG ===" && \
    head -5 /usr/local/searxng/searx/static/themes/simple/img/favicon.svg

# Comprimi
RUN cd /usr/local/searxng/searx/static/themes/simple/img/ && \
    rm -f favicon.svg.gz favicon.svg.br && \
    gzip -9 -k favicon.svg

# Verifica DOPO la compressione
RUN echo "=== AFTER compression ===" && \
    ls -lah /usr/local/searxng/searx/static/themes/simple/img/favicon.* && \
    echo "=== Verify original SVG is still there ===" && \
    head -5 /usr/local/searxng/searx/static/themes/simple/img/favicon.svg

COPY searx/templates/simple/base_index.html /usr/local/searxng/searx/templates/simple/base_index.html
COPY searx/templates/simple/index.html /usr/local/searxng/searx/templates/simple/index.html
COPY searx/templates/simple/results.html /usr/local/searxng/searx/templates/simple/results.html
COPY searx/templates/simple/icons.html /usr/local/searxng/searx/templates/simple/icons.html
COPY searx/templates/simple/base.html /usr/local/searxng/searx/templates/simple/base.html
COPY logo.png /usr/local/searxng/searx/static/themes/simple/img/searxng.png

# Verifica FINALE prima di terminare il build
RUN echo "=== FINAL check ===" && \
    ls -lah /usr/local/searxng/searx/static/themes/simple/img/favicon.* && \
    head -5 /usr/local/searxng/searx/static/themes/simple/img/favicon.svg

RUN chown -R searxng:searxng /etc/searxng/settings.yml
USER searxng
