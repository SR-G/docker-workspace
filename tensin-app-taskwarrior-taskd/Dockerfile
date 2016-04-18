FROM	tensin-base-alpine

ENV	TASKWARRIOR_DATA	/data
ENV	TASKWARRIOR_KEYS	/data/keys/
ENV	TASKWARRIOR_PORT	80
EXPOSE	$TASKWARRIOR_PORT

VOLUME	[$TASKWARRIOR_DATA]
CMD	/opt/taskd/start.sh
WORKDIR	/opt/taskd/

RUN	apk --update add task taskd taskd-pki task-doc taskd-doc

ADD	start.sh /opt/taskd/start.sh
