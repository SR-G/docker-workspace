FROM	tensin-base-ubuntu

EXPOSE	8080
VOLUME	["/data"]

RUN	apt-get update && apt-get -y upgrade && apt-get clean all && \
	apt-get install -y boinc-client

WORKDIR	/data
# CMD	["boinc", "--attach_project", "http://milkyway.cs.rpi.edu/milkyway/", "201071_bf2345de781413edf094e015688b16ca"]
CMD	["boinc"]
