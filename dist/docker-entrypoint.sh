echo "Configuring server..."

if [ -z ${ADMIN_PASSWORD} ]; then
    export ADMIN_PASSWORD="$(openssl rand -hex 16)"
    echo "No admin password specified, setting a random one"
    echo "------------------------------------------------------------------------"
    echo "---- Admin password: ${ADMIN_PASSWORD}               ----"
    echo "------------------------------------------------------------------------"
fi

jq '.basicServerData.name=[env.SERVER_NAME]
    | .baseServerData.ipv4=[env.IP_ADDRESS]
    | .gameplayMode=[env.GAMEPLAY_MODE]
    | .universeSize=[env.UNIVERSE_SIZE]
    | .users.credentials.password=[env.USER_PASSWORD]
    | .admins.credentials.password=[env.ADMIN_PASSWORD]' \
    /portalknights/server_config_default.json > /portalknights/server_config.json

echo "Starting Portal Knights dedicated server..."
wine /portalknights/pk_dedicated_server.exe
