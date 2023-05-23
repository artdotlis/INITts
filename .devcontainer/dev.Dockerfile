FROM docker.io/rockylinux:9

COPY . /tmp/app

WORKDIR /tmp/app

RUN bash ./bin/deploy/prep.sh && bash ./bin/deploy/req.sh

WORKDIR /

RUN rm -rf /tmp/app


ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG WORK_DIR=/workspace
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME 

RUN mkdir -p $WORK_DIR && chown $USERNAME:$USERNAME -R $WORK_DIR
RUN git config --global --add safe.directory $WORK_DIR

USER $USERNAME

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]