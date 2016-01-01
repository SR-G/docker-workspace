FROM	tensin-base-alpine

EXPOSE	80
VOLUME	["/data"]

CMD	["/run.sh"]

# fix php-fpm "Error relocating /usr/bin/php-fpm: __flt_rounds: symbol not found" bug wih musl
RUN	apk update \
	&& apk add bash nginx ca-certificates \
	php-fpm php-json php-zlib php-xml php-pdo php-phar php-openssl \
	php-pdo_mysql php-mysqli \
	php-gd php-iconv php-mcrypt \
	musl

RUN rm -rf /var/cache/apk/*

ADD conf/nginx.conf /etc/nginx/
ADD conf/php-fpm.conf /etc/php/
ADD conf/run.sh /
RUN chmod +x /run.sh
