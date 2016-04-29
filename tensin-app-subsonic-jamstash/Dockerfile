FROM	tensin-base-alpine

EXPOSE	80
CMD	chown -R nginx:nginx /web/ /var/log/nginx/ /tmp/nginx/client-body/ && nginx -g 'daemon off;'

RUN	addgroup -S nginx && \
	adduser -S -H -h /var/empty -s /sbin/nologin -D -G nginx nginx && \
	apk add --update git curl nginx && \
	rm -rf /var/cache/apk/* && mkdir -p /var/log/nginx/ /tmp/nginx/client-body

COPY	nginx/nginx.conf /etc/nginx/nginx.conf
COPY	nginx/default.conf /etc/nginx/conf.d/default.conf

RUN	git clone https://github.com/tsquillario/Jamstash.git /opt/jamstash && \
	mv /opt/jamstash/dist /web/ && \
	rm -rf /opt/jamstash/

WORKDIR	/web/
