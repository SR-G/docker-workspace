FROM	tensin-base-alpine-java-jdk8

# Create directory, downloader JD" and start JD2 for the initial update and creation of config files.
RUN 	mkdir /opt/JDownloader/ && \
	curl -sLo /opt/JDownloader/JDownloader.jar http://installer.jdownloader.org/JDownloader.jar && \
	java -Djava.awt.headless=true -jar /opt/JDownloader/JDownloader.jar


COPY	startJD2.sh /opt/JDownloader/
RUN	chmod +x /opt/JDownloader/startJD2.sh


# Run this when the container is started
CMD	/opt/JDownloader/startJD2.sh
