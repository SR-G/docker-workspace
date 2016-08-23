FROM	tensin-base-alpine

EXPOSE	80
VOLUME	["/data"]

CMD	["/run.sh"]

# fix php-fpm "Error relocating /usr/bin/php-fpm: __flt_rounds: symbol not found" bug wih musl
RUN	apk update \
	&& apk add bash nginx ca-certificates \
	php5-fpm php5-json php5-zlib php5-xml php5-pdo php5-phar php5-openssl \
	php5-pdo_mysql php5-mysqli \
	php5-gd php5-iconv php5-mcrypt \
	musl

RUN rm -rf /var/cache/apk/*

ADD conf/nginx.conf /etc/nginx/
ADD conf/php-fpm.conf /etc/php/
ADD conf/run.sh /
RUN chmod +x /run.sh
