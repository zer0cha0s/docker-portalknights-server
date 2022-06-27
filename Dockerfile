FROM honestventures/steamcmd-linux-wine:ubuntu-20 AS server

WORKDIR /portalknights

RUN apt-get update && \
    apt-get install --no-install-recommends --assume-yes jq && \
    rm -rf /var/lib/apt/lists/*

COPY ./data/* /portalknights/

ENV SERVER_NAME="Portal Knights" \
    GAMEPLAY_MODE="Adventure" \
    UNIVERSE_SIZE="Normal"
VOLUME /portalknights/savedata
EXPOSE 16365

ENTRYPOINT [ "/usr/bin/env" ]
CMD [ "/portalknights/docker-entrypoint.sh" ]
