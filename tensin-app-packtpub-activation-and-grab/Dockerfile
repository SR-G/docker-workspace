FROM	tensin-base-debian-python3

ENTRYPOINT ["python", "packtPublishingFreeEbook.py"]
RUN	apt-get update && apt-get install -y git && \
	mkdir -p /opt/ && \
	git clone https://github.com/igbt6/Packt-Publishing-Free-Learning /opt/packt/ && \
	cd /opt/packt/ && \
	pip install -r requirements.txt
WORKDIR /opt/packt/src/
