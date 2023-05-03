FROM docker.io/rockylinux:9

COPY . /tmp/app

WORKDIR /tmp/app

RUN bash ./bin/deploy.sh

WORKDIR /

RUN rm -rf /tmp/app

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]

HEALTHCHECK --interval=5m --timeout=3s CMD /health.sh
