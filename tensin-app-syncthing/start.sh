#!/bin/bash
# strict mode http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

SYNCTHING_BASEDIR=/opt/syncthing/
SYNCTHING_CONFIG=${SYNCTHING_BASEDIR}/config/
SYNCTHING_DATA=${SYNCTHING_BASEDIR}/data/

# if this if the first run, generate a useful config
if [ ! -f ${SYNCTHING_CONFIG}/config.xml ]; then
  echo "generating config"
  ${SYNCTHING_BASEDIR}/syncthing --generate="${SYNCTHING_CONFIG}"
  # don't take the whole volume with the default so that we can add additional folders
  sed -e 's&id="default" path="/root/Sync/"&id="default" path="/opt/syncthing/data/default"&' -i ${SYNCTHING_CONFIG}/config.xml
  # ensure we can see the web ui outside of the docker container
  sed -e 's&<address>127.0.0.1:8384&<address>0.0.0.0:8080&' -i ${SYNCTHING_CONFIG}/config.xml
fi

usermod -u $UID syncthing
# set permissions so that we have access to volumes
chown -R syncthing:users ${SYNCTHING_CONFIG} ${SYNCTHING_DATA} ${SYNCTHING_BASEDIR}
chmod -R 770 ${SYNCTHING_CONFIG} ${SYNCTHING_DATA}

gosu syncthing ${SYNCTHING_BASEDIR}/syncthing -home=${SYNCTHING_CONFIG}
