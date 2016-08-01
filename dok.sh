#!/bin/zsh

BASEPATH=$(dirname $0)
CONFIG_ALIAS_FILENAME=$BASEPATH/docker-alias.cfg
CONFIG_GLOBAL_FILENAME=$BASEPATH/docker-globals.cfg
[[ ! -f "$CONFIG_ALIAS_FILENAME" ]] && echo "Config [$CONFIG_ALIAS_FILENAME] not found" && exit 1
if [[ -f "$CONFIG_GLOBAL_FILENAME" ]] ; then
  cat $CONFIG_GLOBAL_FILENAME | while read F ; do
    eval "$F"
  done
fi 

function listImages {
  echo "Available images :"
  cat "$CONFIG_ALIAS_FILENAME" | egrep -v "^#|^$" | sort -u | while IFS=$'\t' read -r ALIAS IMG PARAMS_PORTS PARAMS_MISC ; do
    [[ -z "$IMG" ]] && IMG="$ALIAS" 
    [[ "$IMG" = "-" ]] && IMG="$ALIAS" 
    printf " - %-30s[%s]\c" $ALIAS $IMG
    # [[ ! -z "$PARAMS_PORTS" ]] && echo " (ports = $PARAMS_PORTS)\c"
    # [[ ! -z "$PARAMS_MISC" ]] && echo " (params = $PARAMS_MISC)\c"
    echo ""
  done
}

function listPorts {
  cat "$CONFIG_ALIAS_FILENAME" | egrep -v "^#|^$" | sort -u | while IFS=$'\t' read -r ALIAS IMG PARAMS_PORTS PARAMS_MISC ; do
    if [[ "$PARAMS_PORTS" != "-" && "$PARAMS_PORTS" != "" ]] ; then
      for PORTS in $(echo "$PARAMS_PORTS" | sed 's/,/\t/g') ; do
        P=$(echo $PORTS | cut -d":" -f1)
        printf " - %-10s: %s\n" $P $ALIAS >> /tmp/docker.ports$$
      done
    fi
  done
  echo "Used ports :"
  cat /tmp/docker.ports$$ 2>/dev/null | sort -u -n -r
  rm -f /tmp/docker.ports$$ 2>/dev/null 
}

function enterImage {
  ALIAS="$1"
  docker exec -it "$ALIAS" /bin/bash
}

function runImage {
  ALIAS="$1"
  PREVIEW="$2"
  cat "$CONFIG_ALIAS_FILENAME" | grep "^${ALIAS}"$'\t' | read ALIAS IMG PARAMS_PORTS PARAMS_MISC
  [[ -z "$ALIAS" ]] && echo "Alias [$1] undefined in [$CONFIG_ALIAS_FILENAME]" && exit 1
  [[ -z "$IMG" ]] && IMG="$ALIAS" 
  [[ "$IMG" = "-" ]] && IMG="$ALIAS" 
  PORTS=""
  for PORT in $(echo "$PARAMS_PORTS" | sed 's/,/\t/g') ; do
    PORTS="-p $PORT $PORTS"
  done
  [[ ! -z "$PASSWORD" ]] && PARAMS_MISC=$(echo $PARAMS_MISC | sed 's/$PASSWORD/'$PASSWORD'/g')
  [[ ! -z "$GLOBAL" ]] && GLOBAL=$(echo "$GLOBAL" | sed 's/$ALIAS/'$ALIAS'/g')
  CMD="docker run $PORTS $GLOBAL $PARAMS_MISC --name $ALIAS $IMG"
  echo "$CMD"
  [[ -z "$PREVIEW" ]] && eval "$CMD"
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
  EXTRA="$2"
  # [[ ! -d "${ALIAS}" ]] && echo "No path [$ALIAS]" && exit 1
  echo "Now building [$ALIAS]"
  docker build $EXTRA -t "${ALIAS}" "${ALIAS}"
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

function graph {
  DEST="$1"
  [[ -z "$DEST" ]] && DEST="docker-graph.png"
  echo "Now generating graph under [$DEST]"
  docker run --rm -v /var/run/docker.sock:/var/run/docker.sock centurylink/image-graph > $DEST
}

OPERATION=$(echo "$1" | tr "[A-Z]" "[a-z]")
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
  "run")
    runImage "$IMAGE"
    ;;
  "preview")
    runImage "$IMAGE" "PREVIEW"
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
  "force-rebuild")
    buildImage "$IMAGE" "--no-cache"
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
  "graph")
    DEST="$2"
    graph "$DEST"
    ;;
  *)
    echo "Commands:"
cat <<EOF
    build                 Build a contaier
    clean                 Clean logs, images and not running containers
    clean-logs            Clean logs
    clean-images          Clean images
    clean-containers      Clean not running containers
    enter                 Enter through /bin/bash a running container
    force-rebuild         Force rebuild a container
    graph                 Generates a .png of the containers graph
    list                  List configured containers and used ports
    list-containers       List configured containers
    list-ports            List used ports  
    list-stopped          List stopped containers
    purge                 Stop and remove a container
    rebuild               Rebuild a container
    restart               Stop and start again a container
    run                   Run for the first time a container
    preview		  Preview run
    start                 Start a container
    stop                  Stop a container
EOF
    ;;
esac
