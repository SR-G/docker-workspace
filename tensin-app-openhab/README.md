
```
docker run --rm -it -p 8080:8080 -v /home/datas/docker-logs/tensin-app-openhab/:/var/log/ -v /home/datas/docker-datas/openhab/data/:/opt/openhab/data/ --name tensin-app-openhab-new tensin-app-openhab /bin/bash
```

/data/openhab-bootstrap-config

`̀̀ `
PACKAGE runtime runtime
PACKAGE addons runtime/addons-deactivated/
PACKAGE demo demo
PACKAGE designer-linux64bit ide

ADDON org.openhab.action.mqtt
ADDON org.openhab.action.twitter
ADDON org.openhab.action.xmpp
...
```
