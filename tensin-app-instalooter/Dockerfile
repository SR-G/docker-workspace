FROM	tensin-base-debian-python3

ENTRYPOINT	["/usr/local/bin/instalooter"]
CMD	["-h"]
VOLUME	/data
RUN	pip3 install instaLooter
ADD	user-agent.txt /root/.cache/instalooter/2.4.4/
