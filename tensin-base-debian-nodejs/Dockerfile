FROM	tensin-base-debian

RUN	groupadd --gid 1000 node && \
	useradd --uid 1000 --gid node --shell /bin/bash --create-home node

WORKDIR	/src/
VOLUME	["/src/"]

ENV	NODE_ARCH x64
ENV	NODE_HOME /opt/nodejs
ENV	NODE_VERSION 11.1.0
ENV	PATH ${PATH}:${NODE_HOME}/bin/:/opt/yarn/bin

RUN 	mkdir -p /opt/nodejs-${NODE_VERSION}/ && cd /opt/ && apt-get update && apt-get install -y curl git gnupg xz-utils bzip2 apt-transport-https vim zsh && \
  # gpg keys listed at https://github.com/nodejs/node#release-team
  	for key in \
		94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
		FD3A5288F042B6850C66B31F09FE44734EB7990E \
		71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
		DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
		C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
		B9AE9905FFD7803F25714661B63B535A4C206CA9 \
		56730D5401028683275BD23C23EFEFE93C4CFFFE \
		77984A986EBC2AA786BC0F66B01FBB92821C587A \
		8FCCA13FEF1D0C2E91008E09770F7A9A5AE15600 \
	; do \
		gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" || \
		gpg --keyserver hkp://ipv4.pool.sks-keyservers.net --recv-keys "$key" || \
		gpg --keyserver hkp://pgp.mit.edu:80 --recv-keys "$key" ; \
	done && \
	curl -sLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-${NODE_ARCH}.tar.xz" && \
	curl -sLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" && \
	gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc && \
	grep "node-v${NODE_VERSION}-linux-${NODE_ARCH}.tar.xz\$" SHASUMS256.txt | sha256sum -c - && \
	tar -xvf "node-v${NODE_VERSION}-linux-${NODE_ARCH}.tar.xz" -C /opt/nodejs-${NODE_VERSION}/ --strip-components=1 --no-same-owner && \
	rm "node-v$NODE_VERSION-linux-${NODE_ARCH}.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt && \
	ln -s /opt/nodejs-${NODE_VERSION}/ ${NODE_HOME} && \
	for package in grunt grunt-cli ; do \
		echo "Installing additional package [$package]" && \
		npm install -g "$package" ; \
	done && \
	curl -sLO --compressed "https://yarnpkg.com/latest.tar.gz" && \
	tar -xvf latest.tar.gz -C /opt/ --no-same-owner && \
	ln -s /opt/yarn-v*/ /opt/yarn && \
	rm latest.tar.gz && \
	apt-clean
