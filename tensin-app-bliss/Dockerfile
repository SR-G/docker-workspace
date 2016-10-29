FROM	tensin-base-ubuntu-java-jdk8

EXPOSE	3220
VOLUME	["/mp3/"]
WORKDIR	/opt/bliss/

COPY	bliss-install-20160825.jar /opt/bliss/bliss.jar

RUN	java -jar /opt/bliss/bliss.jar -console ; echo 0
# rm *jar *licence bin/*exe bin/*bat 
# rm -rf Uninstaller

