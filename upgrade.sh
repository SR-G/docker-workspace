#!/bin/zsh

FILE_TEMP_DOCKER_IDS=/var/tmp/docker-restart.$$

docker ps -a
docker ps -aq > $FILE_TEMP_DOCKER_IDS

cat "$FILE_TEMP_DOCKER_IDS" | while read ID
do
  echo "About to stop [$ID]"
  docker stop $ID
done

echo "Now upgraing docker daemon"
systemctl stop docker
pacman -S --noconfirm docker
systemctl daemon-reload
systemctl start docker

tac "$FILE_TEMP_DOCKER_IDS" | while read ID
do
  sleep 10
  echo "About to start [$ID]"
  docker start $ID
done


