FROM	tensin-base-ubuntu-supervisor

# Install Java 7
RUN	add-apt-repository ppa:webupd8team/java -y
RUN	apt-get update && apt-get -y upgrade
RUN	echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN	apt-get install -y oracle-java7-installer 
RUN	apt-get clean
RUN	rm -rf /var/cache/oracle*

# Set oracle java as the default java
RUN	update-java-alternatives -s java-7-oracle
RUN	echo "export JAVA_HOME=/usr/lib/jvm/java-7-oracle" >> ~/.bashrc
ENV	JAVA_HOME /usr/lib/jvm/java-7-oracle
