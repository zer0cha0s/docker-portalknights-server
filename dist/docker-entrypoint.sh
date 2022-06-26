echo "Configuring server..."

if [ -z ${ADMIN_PASSWORD} ]; then
    ADMIN_PASSWORD="$(openssl rand -hex 16)"
    echo "No admin password specified, setting a random one"
    echo "------------------------------------------------------------------------"
    echo "---- Admin password: ${ADMIN_PASSWORD}                              ----"
    echo "------------------------------------------------------------------------"

jq '.basicServerData.name='\"${SERVER_NAME}\"'
    | .gameplayMode='\"${GAMEPLAY_MODE}\"'
    | .universeSize='\"${UNIVERSE_SIZE}\"'
    | .admins.credentials.password='\"${ADMIN_PASSWORD}\"'' \
    /portalknights/server_config_default.json \
    > /portalknights/server_config.json

echo "Starting Portal Knights dedicated server..."
wine /portalknights/pk_dedicated_server.exe
