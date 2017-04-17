FROM	tensin-base-alpine

CMD	/bin/bash
WORKDIR	/datas

ENV	PATH $PATH:/opt/hugo/
ENV	HUGO_PACKAGE_URL 	Linux-64bit
ENV	HUGO_PACKAGE_NAME 	linux_amd64
ENV	HUGO_VERSION	 	0.18.1

RUN	apk --update add git curl && \
	mkdir -p /datas/ /opt/ && \
	curl -sSL https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_${HUGO_PACKAGE_URL}.tar.gz | tar xzf - -C /opt/ && \
	mv /opt/hugo_${HUGO_VERSION}_${HUGO_PACKAGE_NAME} /opt/hugo && \
	mv /opt/hugo/hugo_${HUGO_VERSION}_${HUGO_PACKAGE_NAME} /opt/hugo/hugo && \
	rm -rf /opt/hugo_*gz
