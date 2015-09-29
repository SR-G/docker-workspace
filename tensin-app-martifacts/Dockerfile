FROM 	tensin-base-alpine-java-jdk8-maven3

RUN	apk add git

RUN	mkdir -p /opt/martifacts/libs/
WORKDIR	/opt/martifacts/
CMD	["/opt/martifacts/start.sh"]
ADD	start.sh /opt/martifacts/start.sh 
RUN	git clone https://github.com/martylamb/martifacts && \
	cd martifacts && \
	mvn install -Dmaven.test.skip=true && \
	mvn dependency:copy-dependencies && \
	mv target/*.jar ../libs && mv target/dependency/*.jar ../libs && \
	cd - && rm -rf martifacts
