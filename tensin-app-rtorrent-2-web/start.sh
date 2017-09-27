#!/bin/bash

chmod a+r,a+w /run/rtorrent/rtorrent.sock
chown -R nginx:rutorrent /data/www/rutorrent/ 
chmod -R 775 /data/www/rutorrent/* 
chmod -R 664 /data/www/rutorrent/.htpasswd 
chmod -R 777 /data/www/rutorrent/share/

# chgrp -R rtorrent /data/www/
# chmod -R g+r,g+w /data/www/

echo "Starting FPM"
php-fpm7 

echo "Init plugins"
php /data/www/rutorrent/php/initplugins.php

echo "Starting NGINX"
nginx -g "daemon off;"
