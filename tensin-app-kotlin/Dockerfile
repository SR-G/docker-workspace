FROM	tensin-base-alpine-java-jdk8

WORKDIR /opt/kotlin/
ENV	PATH /opt/kotlin/bin:$PATH
ENV	KOTLIN_VERSION 1.1.3-2

RUN	curl -sLo kotlin.zip "https://github.com/JetBrains/kotlin/releases/download/v${KOTLIN_VERSION}/kotlin-compiler-${KOTLIN_VERSION}.zip" && \
	unzip kotlin.zip && mv kotlinc/* . && rm -rf kotlin.zip kotlinc bin/*.bat && \
	chmod a+x bin/*
