#!/bin/bash

if [ -z ${APP_HOME+x} ]; then
    echo "[ERROR] Application Home environment variable APP_HOME is not set: $APP_HOME"
	exit 1
fi

# show the info text
cat /init/info.txt
echo "[INFO] Docker image version: $VERSION"

# run the default config script
source /init/config.sh

# chown the APP directory by the new user
echo "[INFO] Change the ownership of $APP_HOME (including subfolders) to $PUSER:$PGROUP"
chown $PUSER:$PGROUP -R $APP_HOME

# get or update APP
source /init/get_or_update.sh

# launch the APP
source /init/launch.sh
