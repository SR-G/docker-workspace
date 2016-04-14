#!/bin/zsh

CONFIG=docker.cfg
[[ ! -f "$CONFIG" ]] && echo "Config [$CONFIG] not found" && exit 1

function listImages {
  echo "Available images :"
  cat "$CONFIG" | egrep -v "^#|^$" | sort -u | while IFS=$'\t' read -r ALIAS IMG PARAMS_PORTS PARAMS_MISC ; do
    [[ -z "$IMG" || "$IMG" = "-" ]] && IMG="$ALIAS"
    echo " - $ALIAS (image $IMG)\c"
    # [[ ! -z "$PARAMS_PORTS" ]] && echo " (ports = $PARAMS_PORTS)\c"
    # [[ ! -z "$PARAMS_MISC" ]] && echo " (params = $PARAMS_MISC)\c"
    echo ""
  done
}

function listPorts {
  cat "$CONFIG" | egrep -v "^#|^$" | sort -u | while IFS=$'\t' read -r ALIAS IMG PARAMS_PORTS PARAMS_MISC ; do
    if [[ "$PARAMS_PORTS" != "-" && "$PARAMS_PORTS" != "" ]] ; then
      for PORTS in $(echo "$PARAMS_PORTS" | sed 's/,/\t/g') ; do
        P=$(echo $PORTS | cut -d":" -f1)
        echo "$P  -> $ALIAS"  >> /tmp/docker.ports$$
      done
    fi
  done
  echo "Used ports :"
  cat /tmp/docker.ports$$ | sort -n | while read PORT ; do
    echo " - $PORT"
  done
  rm -f /tmp/docker.ports$$
}

function enterImage {
  ALIAS="$1"
  docker exec -it "$ALIAS" /bin/bash
}

function startImage {
  ALIAS="$1"
  cat "$CONFIG" | grep "^${ALIAS}"$'\t' | read ALIAS IMG PARAMS_PORTS PARAMS_MISC
  [[ -z "$ALIAS" ]] && echo "Alias [$1] undefined in [$CONFIG]" && exit 1
  [[ -z "$IMG" || "$IMG" = "-" ]] && IMG="$ALIAS"
  PORTS=""
  for PORT in $(echo "$PARAMS_PORTS" | sed 's/,/\t/g') ; do
    PORTS="-p $PORT $PORTS"
  done
  # TODO put this in config
  PARAMS_GLOBAL="-v /home/datas/logs/$ALIAS/:/var/log/"
  echo docker run -d $PORTS $PARAMS_GLOBAL $PARAMS_MISC --name "$ALIAS" "$IMAGE"
}

function stopImage {
  ALIAS="$1"
  docker stop $ALIAS
}

function purgeImage {
  ALIAS="$1"
  docker stop $ALIAS
  docker rm $ALIAS
}

function buildImage {
  ALIAS="$1"
  # [[ ! -d "${ALIAS}" ]] && echo "No path [$ALIAS]" && exit 1
  echo "Now building [$ALIAS]"
  docker build -t "${ALIAS}" "${ALIAS}"
}


function cleanLogs {
  docker ps -a -q | while read DOCKER_ID ; do
    LOG_FILE=$(docker inspect --format='{{.LogPath}}' $DOCKER_ID)
    CONTAINER_NAME=$(docker inspect --format='{{.Name}}' $DOCKER_ID)
    if [[ ! -z "$LOG_FILE" && -f "$LOG_FILE" ]] ; then
      printf "%35s\t%s\t%s\n" $CONTAINER_NAME $(du -ksh "$LOG_FILE")
      cat /dev/null > "$LOG_FILE"
    fi
  done
}

function cleanImages {
  echo "Purge images"
  # docker rmi $(docker images -q)
  docker images --no-trunc|grep none|awk '{print $3}'|xargs -r docker rmi
}

function cleanContainers {
  echo "Purge containers"
  docker rm $(docker ps -a -q)
}

function listStoppedContainers {
  F1=/tmp/docker-containers-all.$$
  F2=/tmp/docker-containers-running.$$
  docker ps -aq | sort > $F1
  docker ps -q | sort > $F2
  echo "Stopped containers ..."
  comm -23 $F1 $F2 | while read ID ; do
    docker ps -a | grep $ID
  done
  rm -f $F1 $F2
}

OPERATION="$1"
IMAGE="$2"

case "$OPERATION" in
  "list-images")
    listImages
    ;; 
  "list-ports")
    listPorts
    ;;
  "list-stopped")
    listStoppedContainers
    ;;
  "list")
    listImages
    listPorts
    ;;
  "enter")
    enterImage "$IMAGE"
    ;;
  "start")
    startImage "$IMAGE"
    ;;
  "stop")
    stopImage "$IMAGE"
    ;;
  "purge")
    purgeImage "$IMAGE"
    ;;
  "build")
    buildImage "$IMAGE"
    ;;
  "rebuild")
    rebuildImage "$IMAGE"
    ;;
  "restart")
    stopImage "$IMAGE"
    startImage "$IMAGE"
    ;;
  "clean")
    cleanLogs
    cleanContainers
    cleanImages
    ;;
  "clean-logs")
    cleanLogs 
    ;;
  "clean-images")
    cleanImages
    ;;
  "clean-containers")
    cleanContainers
    ;;
  *)
    echo "Commands:"
cat <<EOF
    build                     Build a contaier
    clean                     Clean logs, images and not running containers
    clean-logs                Clean logs
    clean-images              Clean images
    clean-containers          Clean not running containers
    enter                     Enter through /bin/bash a running container
    force-rebuuild            Force rebuild a container
    list                      List configured containers and used ports
    list-containers           List configured containers
    list-ports                List used ports  
    list-stopped-containers   List stopped containers
    purge                     Stop and remove a container
    rebuild                   Rebuild a container
    restart                   Stop and start again a container
    start                     Start a container
    stop                      Stop a container
EOF
    ;;
esac
