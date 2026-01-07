FROM searxng/searxng:latest
COPY settings.yml /etc/searxng/settings.yml
COPY searx/templates/static/themes/simple/highlight.css /usr/local/searxng/searx/static/themes/simple/highlight.css
COPY searx/templates/static/themes/simple/img/favicon.png /usr/local/searxng/searx/static/themes/simple/img/favicon.png
COPY searx/templates/static/themes/simple/img/favicon.svg /usr/local/searxng/searx/static/themes/simple/img/favicon.svg

# DEBUG: mostra dove sono i file
RUN echo "=== Searching for favicon files ===" && \
    find / -name "favicon.*" 2>/dev/null && \
    echo "=== SearXNG directories ===" && \
    find / -type d -name "*searx*" 2>/dev/null && \
    echo "=== Content of target directory ===" && \
    ls -la /usr/local/searxng/searx/static/themes/simple/img/ 2>/dev/null || echo "Directory not found"

COPY searx/templates/simple/base_index.html /usr/local/searxng/searx/templates/simple/base_index.html
COPY searx/templates/simple/index.html /usr/local/searxng/searx/templates/simple/index.html
COPY searx/templates/simple/results.html /usr/local/searxng/searx/templates/simple/results.html
COPY searx/templates/simple/icons.html /usr/local/searxng/searx/templates/simple/icons.html
COPY searx/templates/simple/base.html /usr/local/searxng/searx/templates/simple/base.html
COPY logo.png /usr/local/searxng/searx/static/themes/simple/img/searxng.png
USER root
RUN chown -R searxng:searxng /etc/searxng/settings.yml
USER searxng
