FROM honestventures/steamcmd-linux-wine:ubuntu-20 AS server

WORKDIR /portalknights

RUN apt-get update && \
    apt-get install --no-install-recommends jq && \
    rm -rf /var/lib/apt/lists/*

# Don't copy the readme files to minimise image size
COPY ./dedicated_server/pk_dedicated_server* ./dedicated_server/server_core* \
    /portalknights/
COPY dist/* /portalknights/

ENV SERVER_NAME="Portal Knights" \
    GAMEPLAY_MODE="Adventure" \
    UNIVERSE_SIZE="Normal"
VOLUME /portalknights/savedata
EXPOSE 16365

CMD [ "/portalknights/docker-entrypoint.sh" ]
