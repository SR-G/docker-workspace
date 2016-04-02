FROM	tensin-base-alpine

VOLUME	["/etc/ssh"]
EXPOSE	22
WORKDIR	/opt/jail/
ENTRYPOINT ["/opt/jail/start-sshd"]

# sshd needs /var/run/sshd to run
RUN	mkdir -p /var/run/sshd && \
	apk --update add openssh

COPY	sshd_config /etc/ssh/sshd_config
COPY	start-sshd /opt/jail/
