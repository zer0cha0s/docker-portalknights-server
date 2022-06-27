FROM honestventures/steamcmd-linux-wine:ubuntu-20 AS downloader

ARG STEAM_USERNAME
ARG STEAM_PASSWORD

RUN apt update \
    && apt install -y --no-install-recommends unzip jq \
    && steamcmd \
        +@sSteamCmdForcePlatformType windows \
        +force_install_dir /data \
        +login ${STEAM_USERNAME} ${STEAM_PASSWORD} \
        +app_update 374040 \
        +quit \
    && unzip -d /dedicated_server /data/dedicated_server.zip \
RUN chmod -R a+rwx /dedicated_server \
    && cat /data/steamapps/appmanifest_374040.acf \
        | sed -rn 's/\s*\"buildid\"\s+\"([0-9]+)\"/\1/p' \
        >> /dedicated_server/pk-build-id.txt \
    && chmod a+rwx /dedicated_server/*

FROM scratch AS exporter

# Don't copy the readme files to minimise image size
COPY --from=downloader \
    /dedicated_server/pk_dedicated_server* \
    /dedicated_server/server_core* \
    /dedicated_server/pk-build-id.txt \
    /
