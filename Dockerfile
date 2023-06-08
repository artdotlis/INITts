FROM docker.io/rockylinux:9 AS builder

COPY . /tmp/app

WORKDIR /tmp/app

RUN CGO_ENABLED=0 bash ./bin/deploy.sh

FROM docker.io/nginx:stable

WORKDIR /var/www/

COPY --from=builder /var/www/ ./

HEALTHCHECK --interval=5m --timeout=3s CMD /health.sh
