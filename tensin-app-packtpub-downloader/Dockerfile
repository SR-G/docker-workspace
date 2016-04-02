FROM	tensin-base-alpine-python2

ENTRYPOINT	["python", "/opt/packtpub-library-downloader/downloader.py"]

VOLUME	["/data/"]
WORKDIR	/opt/packtpub-library-downloader/

ADD 	https://raw.githubusercontent.com/ozzieperez/packtpub-library-downloader/master/downloader.py /opt/packtpub-library-downloader/
RUN	apk --update add build-base python-dev libxslt-dev libxml2 libxml2-dev && pip install --upgrade pip && pip install requests lxml
