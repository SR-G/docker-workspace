FROM	tensin-base-alpine-python2

RUN	apk --update add git && \
	git clone https://github.com/ejwa/gitinspector.git /opt/gitinspector/

ENTRYPOINT	/opt/gitinspector/gitinspector.py
