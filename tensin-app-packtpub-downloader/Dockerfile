FROM	tensin-base-alpine-python3

ENTRYPOINT	["python3", "/opt/packtpub-library-downloader/downloader.py"]

VOLUME	["/data/"]
WORKDIR	/opt/packtpub-library-downloader/

ADD 	https://raw.githubusercontent.com/ozzieperez/packtpub-library-downloader/master/downloader.py /opt/packtpub-library-downloader/
RUN	apk --update add build-base python3-dev libxslt-dev libxml2 libxml2-dev && pip3 install requests lxml
