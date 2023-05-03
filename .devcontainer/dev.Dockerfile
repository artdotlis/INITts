FROM docker.io/rockylinux:9

COPY . /tmp/app

WORKDIR /tmp/app

RUN bash ./bin/deploy/prep.sh && bash ./bin/deploy/req.sh

WORKDIR /

RUN rm -rf /tmp/app

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]