FROM	tensin-base-alpine

EXPOSE	1313
CMD	hugo serve . --bind=0.0.0.0 --baseUrl=http://192.168.8.4/
VOLUME	["/data/"]
WORKDIR	/data
ENV	PATH $PATH:/opt/pygments/:/opt/hugo/
ENV	HUGO_PACKAGE	 linux_amd64
ENV	HUGO_VERSION	 0.15
ENV	PYGMENTS_VERSION 2.1.1

RUN	apk --update add git python curl && \
	mkdir -p /opt/hugo/ && \
	curl -sSL https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_${HUGO_PACKAGE}.tar.gz | tar xzf - -C /opt/ && \
	curl -sSL https://pypi.python.org/packages/source/P/Pygments/Pygments-${PYGMENTS_VERSION}.tar.gz | tar xzf - -C /opt/ && \
	mv /opt/hugo_${HUGO_VERSION}_${HUGO_PACKAGE}/hugo_${HUGO_VERSION}_${HUGO_PACKAGE} /opt/hugo/hugo && \
	mv /opt/Pygments-${PYGMENTS_VERSION}/ /opt/pygments/ && \
	rm -rf /opt/hugo_${HUGO_VERSION}_${HUGO_PACKAGE} && \
	cd /opt/pygments/ && python setup.py install
