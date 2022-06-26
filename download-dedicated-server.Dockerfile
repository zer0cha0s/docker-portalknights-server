FROM steamcmd/steamcmd:windows-core-1809 AS downloader

ARG STEAM_USERNAME
ARG STEAM_PASSWORD

ENV STEAM_USERNAME=${STEAM_USERNAME} STEAM_PASSWORD=${STEAM_PASSWORD}

RUN steamcmd +login ${STEAM_USERNAME} ${STEAM_PASSWORD} +force_install_dir "c:\data" +app_update 374040 +quit


FROM scratch as exporter

COPY --from=downloader c:\data\dedicated_server.zip .
