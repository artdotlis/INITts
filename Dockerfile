FROM docker.io/rockylinux:9 AS builder

COPY . /tmp/app

WORKDIR /tmp/app

RUN CGO_ENABLED=0 bash ./bin/deploy.sh

FROM docker.io/nginx:stable

WORKDIR /var/www/

COPY --from=builder /var/www/ ./

COPY --from=builder /tmp/app /tmp/app

RUN if grep -e "production:\s*true," "/tmp/app/src/strinfui/ts/configs/project.js";then rm -rf /tmp/app; fi

HEALTHCHECK --interval=5m --timeout=3s CMD /health.sh
