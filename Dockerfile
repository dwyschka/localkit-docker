FROM serversideup/php:8.4-fpm-nginx

ENV AUTORUN_ENABLED=true
ENV NGINX_HTTP_PORT=80
ENV NGINX_HTTPS_PORT=443
ENV SSL_MODE=mixed

ARG TARGETARCH
ARG TARGETPLATFORM

USER root

RUN install-php-extensions intl

RUN set -ex; \
    case "$TARGETPLATFORM" in \
        "linux/amd64")  ARCH="amd64" ;; \
        "linux/arm64")  ARCH="arm64" ;; \
        "linux/arm/v7") ARCH="armv7" ;; \
        *) echo "Unsupported platform: $TARGETPLATFORM" && exit 1 ;; \
    esac; \
    curl -fsSL -o /usr/local/bin/go2rtc \
        "https://github.com/AlexxIT/go2rtc/releases/latest/download/go2rtc_linux_${ARCH}"; \
    chmod +x /usr/local/bin/go2rtc