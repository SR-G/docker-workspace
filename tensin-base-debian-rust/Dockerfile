FROM	tensin-base-debian

WORKDIR	/workspace/

ENV 	PATH=/root/.cargo/bin:$PATH

ADD	.vimrc /root/.vimrc

RUN	apt-get update && apt-get install -y procps curl git jq make zip unzip vim openssl ca-certificates file build-essential autoconf automake autotools-dev libtool xutils-dev && \
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain stable -y && \
	git config --global user.email "serge.simon@gmail.com" && \
	git config --global user.name "SR-G" 
