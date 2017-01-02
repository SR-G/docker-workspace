#!/bin/zsh

FILE_TEMP_DOCKER_IDS=/var/tmp/docker-restart.$$

docker ps -a
docker ps -aq > $FILE_TEMP_DOCKER_IDS

cat "$FILE_TEMP_DOCKER_IDS" | while read ID
do
  echo "About to stop [$ID]"
  docker stop $ID
done

rm -f "/home/datas/docker-datas/plex/config/Library/Application Support/Plex Media Server/plexmediaserver.pid"

echo "Now upgraing docker daemon"
systemctl stop docker
pacman -S --noconfirm docker

echo "Continue ?"
read ANSWER

systemctl daemon-reload
systemctl start docker

echo "Wait 5 secs for daemon docker to start ..."
sleep 5

tac "$FILE_TEMP_DOCKER_IDS" | while read ID
do
  echo "About to start [$ID]"
  docker start $ID
  sleep 10
done


