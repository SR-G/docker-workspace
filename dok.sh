#!/bin/zsh

BASEPATH=$(dirname $0)
CR=0
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
  CR=$?
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
  # DEST="$1"
  # [[ -z "$DEST" ]] && DEST="docker-graph.png"
  # echo "Now generating graph under [$DEST]"
  # docker run --rm -v /var/run/docker.sock:/var/run/docker.sock centurylink/image-graph > $DEST

  OUTPUT=graphs/docker.dot
  DOCKER_IMAGES=/tmp/docker-images.$$
  echo "digraph docker {" > "${OUTPUT}"
  echo "rankdir=LR" >> "${OUTPUT}"
  docker images | awk ' { print $1 } ' > "${DOCKER_IMAGES}"
  grep -R FROM */Dockerfile | while read A FROM DUMMY ; do
    IMAGE=${A%%/*}
    S="  \"${FROM}\" -> \"${IMAGE}\";"
    ROOT_FROM=${FROM%%:*}
    # removes duplicates
    if [[ $(grep "${S}" "${OUTPUT}" | wc -l) -eq 0 ]] ; then
      # handles colors / RED = parent image not found / GREEN = BASE image / YELLOW = FROM is external image
      [[ $(echo "$IMAGE" | grep "base" | wc -l) -ne 0 ]] && echo "  \"${IMAGE}\"[style=filled, color=green4, fillcolor=greenyellow];" >> "${OUTPUT}"
      [[ $(echo "$FROM" | grep "tensin" | wc -l) -eq 0 ]] && echo "  \"${FROM}\"[style=filled, color=goldenrod3, fillcolor=gold];" >> "${OUTPUT}"
      [[ $(grep "${ROOT_FROM}" "${DOCKER_IMAGES}" | wc -l) -eq 0 ]] && echo "  \"${FROM}\"[style=filled, color=red3, fillcolor=red];" >> "${OUTPUT}"
      [[ $(grep "${IMAGE}" "${DOCKER_IMAGES}" | wc -l) -eq 0 ]] && echo "  \"${IMAGE}\"[style=filled, color=red3, fillcolor=red];" >> "${OUTPUT}"
      echo "${S}" >> "${OUTPUT}"
    fi
  done
  echo "}" >> "${OUTPUT}"

  docker run --rm --name graphviz -v $(pwd):/data -w /data tensin-app-graphviz dot -Tpng graphs/docker.dot > graphs/docker.png
  cp graphs/docker.png $UNXDOWN/
}

function extractDockerfile {
  IMAGE="$1"
  docker history --no-trunc "$IMAGE" | sed -n -e 's,.*/bin/sh -c #(nop) \(MAINTAINER .*[^ ]\) *0 B,\1,p' | head -1
  docker inspect --format='{{range $e := .Config.Env}}
ENV {{$e}}
{{end}}{{range $e,$v := .Config.ExposedPorts}}
EXPOSE {{$e}}
{{end}}{{range $e,$v := .Config.Volumes}}
VOLUME {{$e}}
{{end}}{{with .Config.User}}USER {{.}}{{end}}
{{with .Config.WorkingDir}}WORKDIR {{.}}{{end}}
{{with .Config.Entrypoint}}ENTRYPOINT {{json .}}{{end}}
{{with .Config.Cmd}}CMD {{json .}}{{end}}
{{with .Config.OnBuild}}ONBUILD {{json .}}{{end}}' "$IMAGE"
}

function updateImages {
  typeset IMAGE_NAMES=$1
  ERROR_LOG=/tmp/dok-rebuild-images.txt.$$
  echo "========= Images to be processed : \n"
  for IMAGE_NAME in $(echo "$IMAGE_NAMES") ; do
    echo "  - $IMAGE_NAME"
  done
  for IMAGE_NAME in $(echo "$IMAGE_NAMES") ; do
    if [[ -f "$IMAGE_NAME/Dockerfile" ]] ; then
      echo ""
      echo "======== Building [$IMAGE_NAME]\n"
      ./dok.sh build "$IMAGE_NAME"
      CR=$?
      [[ "$CR" -ne 0 ]] && echo "ERROR when building [$IMAGE_NAME]" >> "$ERROR_LOG"
    else
      echo ""
      echo "======== Pulling [$IMAGE_NAME]\n"
      docker pull "$IMAGE_NAME"
      CR=$?
      [[ "$CR" -ne 0 ]] && echo "ERROR when pulling [$IMAGE_NAME]" >> "$ERROR_LOG"
    fi
  done
  if [[ -f "$ERROR_LOG" ]] ; then
    echo "\n\n\nEncountered errors : \n"
    cat "$ERROR_LOG" 2>/dev/null
    rm -f "$ERROR_LOG" 2>/dev/null
  fi
}

function updateRemoteParentImages {
  grep "^FROM" */Dockerfile|awk '{ print $2}'|grep -v ubuntu|grep -v tensin > /tmp/image_names.$$
  cat docker-alias.cfg|grep -v "^$"|grep -v "^#"|awk '{print $1,$2}'|grep -v "tensin"|while read ALIAS IMAGE_NAME ; do
    [[ "$IMAGE_NAME" == "-" ]] && IMAGE_NAME="$ALIAS"
    echo "$IMAGE_NAME" >> /tmp/image_names.$$
  done
  IMAGES_NAMES=$(cat /tmp/image_names.$$ | sort -u | tr "\n" " ")
  updateImages "$IMAGES_NAMES"
}

function updateLocalParentImages {
  IMAGE_NAMES=$(grep "^FROM" */Dockerfile|awk '{ print $2}'|sort -u|grep -v ubuntu|grep tensin)
  updateImages "$IMAGE_NAMES"
}

function updateLocalImages {
  IMAGE_NAMES=$(ls -1d */ | grep -v "tensin-base-" | sed 's&/$&&')
  updateImages "$IMAGE_NAMES"
}

function updateLocallyUsedImages {
  IMAGE_NAMES=""
  cat docker-alias.cfg|grep -v "^$"|grep -v "^#"|awk '{print $1,$2}'|grep "tensin"|sort|while read ALIAS IMAGE_NAME ; do
    [[ "$IMAGE_NAME" == "-" ]] && IMAGE_NAME="$ALIAS"
    IMAGE_NAMES="${IMAGE_NAMES} ${IMAGE_NAME}"
  done
  updateImages "$IMAGE_NAMES"
}

OPERATION=$(echo "$1" | tr "[A-Z]" "[a-z]")
IMAGE="$2"

case "$OPERATION" in
  "update-local-images") # Update all local images
    updateLocalImages
    ;;
  "update-locally-used-images") # Update images really locally used in docker-alias.cfg
    updateLocallyUsedImages
    ;;
  "update-local-parent-images") # Update all local parent images (base images)
    updateLocalParentImages
    ;;
  "update-remote-parent-images") # Update (pull) all remote parent images
    updateRemoteParentImages
    ;;
  "update-all-images") # Update all images (used or not, local or remote)
    updateRemoteParentImages
    updateLocalParentImages
    updateLocallyUsedImages
    updateLocalImages
    ;; 
  "list-images") # List all images
    listImages
    ;; 
  "list-ports") # List used ports
    listPorts
    ;;
  "list-stopped") # List stopped containers
    listStoppedContainers
    ;;
  "list") # List configured containers and used ports
    listImages
    listPorts
    ;;
  "enter") # Enter through /bin/bash a running container
    enterImage "$IMAGE"
    ;;
  "run") # Run for the first time a container
    runImage "$IMAGE"
    ;;
  "refresh") # Stop, rm, re-run a container
    purgeImage "$IMAGE"
    runImage "$IMAGE"  
    ;;
  "preview") # Preview run command
    runImage "$IMAGE" "PREVIEW"
    ;;
  "start") # Start a stopped container
    startImage "$IMAGE"
    ;;
  "stop") # Stop a running container
    stopImage "$IMAGE"
    ;;
  "purge") # Stop and remove a container
    purgeImage "$IMAGE"
    ;;
  "build") # Build a container
    buildImage "$IMAGE"
    ;;
  "force-rebuild") # Force rebuild a container
    buildImage "$IMAGE" "--no-cache"
    ;;
  "restart") # Stop and start again a container
    stopImage "$IMAGE"
    runImage "$IMAGE"
    ;;
  "clean") # Clean logs, images and not running containers
    cleanLogs
    cleanContainers
    cleanImages
    ;;
  "clean-logs") # Clean logs
    cleanLogs 
    ;;
  "clean-images") # Clean images
    cleanImages
    ;;
  "clean-containers") # Clean not running containers
    cleanContainers
    ;;
  "graph") # Generates a .png of the containers graph
    DEST="$2"
    graph "$DEST"
    ;;
  "extract-dockerfile") # Create docker file from image
    extractDockerfile "$IMAGE"
    ;;
  *)
    echo "Commands:"

    cat "$0" | grep "\".*\") #"  | grep -v cat | sort | while read A B ; do
      COMMAND_NAME=$(echo "$A" | sed -e 's/"//g' -e 's/)//g')
      COMMAND_DESCRIPTION=$(echo "$B" | sed -e 's/# //')
      printf "    %-32s %s\n" "$COMMAND_NAME" "$COMMAND_DESCRIPTION"
done
    ;;
esac

exit $CR
