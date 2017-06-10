FROM	yavin/alpine-php-fpm:7.1

WORKDIR	/opt/commitstrip-downloader/
CMD	["php", "download.php"]
VOLUME	/datas/

ADD	https://raw.githubusercontent.com/CodeBrauer/commitstrip-downloader/master/download.php /opt/commitstrip-downloader/

RUN	chmod a+x /opt/commitstrip-downloader/download.php
