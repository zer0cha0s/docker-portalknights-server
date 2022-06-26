FROM steamcmd/steamcmd:ubuntu-20 AS downloader

ARG STEAM_USERNAME
ARG STEAM_PASSWORD

RUN apt update \
    && apt install -y --no-install-recommends unzip \
    && steamcmd \
        +@sSteamCmdForcePlatformType windows \
        +force_install_dir /data \
        +login ${STEAM_USERNAME} ${STEAM_PASSWORD} \
        +app_update 374040 \
        +quit \
    && unzip -d /dedicated_server /data/dedicated_server.zip

FROM honestventures/steamcmd-linux-wine:ubuntu-20 AS server

WORKDIR /portalknights

RUN apt-get update && \
    apt-get install --no-install-recommends --assume-yes jq && \
    rm -rf /var/lib/apt/lists/*

# Don't copy the readme files to minimise image size
COPY --from=downloader \
    ./dedicated_server/pk_dedicated_server* \
    ./dedicated_server/server_core* \
    /portalknights/
COPY dist/* /portalknights/

ENV SERVER_NAME="Portal Knights" \
    GAMEPLAY_MODE="Adventure" \
    UNIVERSE_SIZE="Normal"
VOLUME /portalknights/savedata
EXPOSE 16365

ENTRYPOINT [ "/usr/bin/env" ]
CMD [ "/portalknights/docker-entrypoint.sh" ]
