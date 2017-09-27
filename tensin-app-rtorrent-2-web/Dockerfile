FROM	tensin-base-alpine
USER	root

EXPOSE	80 443
VOLUME  ["/data/"]
CMD	["/opt/start.sh"]
WORKDIR	/data/

# install
RUN	apk update && apk add --no-cache curl fcgi ca-certificates php7 php7-cli php7-fpm php7-json php7-pear php7-mbstring geoip nginx && \
	addgroup -g 1000 rtorrent && \
	addgroup nginx rtorrent && \
	adduser -D rutorrent && \
	addgroup rutorrent rutorrent && \
	addgroup rutorrent rtorrent && \
	mkdir -p /data/rutorrent/config/torrents /run/nginx/ /run/php/ && \
	rm -rf /etc/php7/php-fpm.d/www.conf /etc/nginx/conf.d/* /etc/nginx/ssl /var/www/localhost/ && \
	sed -i.bak -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=1/" /etc/php7/php.ini && \
	sed -i.bak -e 's&access_log&upstream backendrutorrent {\n\t\tserver unix:/run/php/php-fpm-rutorrent.sock;\n\t}\n\tupstream backendrtorrent {\n\t\tserver unix:/run/rtorrent/rtorrent.sock;\n\t}\n\n\taccess_log&' /etc/nginx/nginx.conf 

ADD	rutorrent-php-fpm.conf /etc/php7/php-fpm.d/
ADD	rutorrent-nginx-basic.conf /etc/nginx/conf.d/
ADD	start.sh /opt/
