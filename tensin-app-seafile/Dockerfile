FROM		tensin-base-debian-supervisor
# Interface the environment
RUN 		mkdir /opt/seafile
VOLUME 		["/opt/seafile"]
EXPOSE		10001 12001 8000 8080 8082

# Seafile dependencies and system configuration
# socat : Workaround for https://github.com/haiwen/seafile/issues/478

RUN		apt-get update && apt-get install -y procps net-tools python3 python3-setuptools python3-pip python3-simplejson sqlite3 python3-memcache default-libmysqlclient-dev socat && \
		pip3 install --timeout=3600 \
			Pillow pylibmc captcha jinja2 \
			django-pylibmc django-simple-captcha \
			lxml pgrep \
			future mysqlclient sqlalchemy==1.4.3 \
			python3-ldap && \
		apt-clean

# Seafile daemons
ADD		seafile.sv.conf /etc/supervisor/conf.d/
ADD		seahub.sv.conf /etc/supervisor/conf.d/
