#!/bin/sh
[ -z "$UID" ] && UID=1000
[ -z "$GID" ] && GID=1001

echo "Adding user [$USER], uid [$UID], gid [$GID]"

groupadd -r $USER -g $GID 
useradd -u $UID -r -g $USER -d /home/$USER -s /bin/bash -c "$USER" $USER 
adduser $USER sudo
[ ! -d /home/$USER ] && mkdir /home/$USER && chown -R $USER:$USER /home/$USER

echo $USER':'$PASSWORD | chpasswd

/etc/NX/nxserver --startup
tail -f /usr/NX/var/log/nxserver.log
