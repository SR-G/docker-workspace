FROM 	tensin-base-alpine

VOLUME	["/downloads/"] 

RUN	apk add --update git musl python3 && rm /var/cache/apk/*

# Install from source + cleanup
WORKDIR	/opt/scdl/
RUN	git clone https://github.com/flyingrub/scdl /opt/scdl/ && \
	pip3 install scdl six
