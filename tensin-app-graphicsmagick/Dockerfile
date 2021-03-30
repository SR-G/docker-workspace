FROM	tensin-base-debian

WORKDIR	/data
VOLUME	["/data"]

CMD	["/bin/bash"]

RUN	apt-get update && apt-get install -y git curl tar ca-certificates graphicsmagick poppler-utils && apt-clean
