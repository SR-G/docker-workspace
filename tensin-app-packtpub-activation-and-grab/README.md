
Example of crontab 

```
11			4	*	*	*		PYTHONIOENCODING=utf-8 && /usr/bin/docker run --rm -v /home/datas/docker-config/packtpub/configFile.cfg:/opt/packt/src/configFile.cfg -v /home/downloads/downloaded/packt:/data/ --name tensin-app-packtpub-activation-and-grab tensin-app-packtpub-activation-and-grab -sm -gl > /var/log/cron-tensin-app-packtpub-activation.log
10			5	*	*	*		PYTHONIOENCODING=utf-8 && /usr/bin/docker run --rm -v /home/datas/docker-config/packtpub/configFile.cfg:/opt/packt/src/configFile.cfg -v /home/downloads/downloaded/packt2:/data/ --name tensin-app-packtpub-activation-and-grab tensin-app-packtpub-activation-and-grab -da -f > /var/log/cron-tensin-app-packtpub-grab.log
```

