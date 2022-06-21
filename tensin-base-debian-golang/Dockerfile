FROM	tensin-base-debian

WORKDIR	/workspace/

ENV	GO_HOME /opt/go/
ENV	PATH ${PATH}:${GO_HOME}/bin
ENV	GO_VERSION 1.18.3
ENV	GO_PACKAGE linux-amd64
ENV	INSTALL_DIRECTORY /usr/local/bin/

RUN	apt-get update && apt-get install -y procps curl git jq make zip unzip vim openssl && \
	mkdir -p /opt/ && cd /opt/ && \
	curl -sL https://dl.google.com/go/go${GO_VERSION}.${GO_PACKAGE}.tar.gz | tar xzf - -C /opt/ && \
	mv /opt/go /opt/go-${GO_VERSION}/ && ln -s /opt/go-${GO_VERSION}/ /opt/go && \
	curl -sL https://git.io/tusk | bash -s -- -b ${INSTALL_DIRECTORY} latest && \
	curl -sL https://raw.githubusercontent.com/golang/dep/master/install.sh | bash && \
	git config --global user.email "serge.simon@gmail.com" && \
	git config --global user.name "SR-G" 

ADD	.vimrc /root/.vimrc
