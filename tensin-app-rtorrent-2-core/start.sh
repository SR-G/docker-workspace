#!/bin/sh

[ ! -d /data/rtorrent/.session/ ] && mkdir -p /data/rtorrent/.session/
chgrp -R rtorrent /data/rtorrent/
chmod -R g+r,g+w /data/rtorrent/

if test -e /data/rtorrent/.session/rtorrent.lock && test -z $(pidof rtorrent) ; then
  rm -f /data/rtorrent/.session/rtorrent.lock
fi

touch /var/log/rtorrent.log
/usr/bin/tmux new-session -s rtorrent -n rtorrent -d /usr/bin/rtorrent 
tail -f /var/log/rtorrent.log

# while sleep 1; do
#  # exit if cannot send signal to tmux's server
#  kill -0 $TMUX_SERVER_PID > /dev/null 2>&1 || exit 0
# done
