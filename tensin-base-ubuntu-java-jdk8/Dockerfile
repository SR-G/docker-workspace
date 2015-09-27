FROM	tensin-base-ubuntu-supervisor

# Install Java 8
RUN	echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN	add-apt-repository ppa:webupd8team/java -y
RUN	apt-get update && apt-get -y upgrade
RUN	apt-get install -y oracle-java8-installer 
RUN	apt-get clean
RUN	rm -rf /var/cache/oracle*

# Set oracle java as the default java
RUN	update-java-alternatives -s java-8-oracle
RUN	echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> ~/.bashrc
ENV	JAVA_HOME /usr/lib/jvm/java-8-oracle
