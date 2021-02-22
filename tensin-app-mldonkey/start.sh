#!/bin/bash

[ -f /root/.mldonkey/downloads.ini ] && rm -f /root/.mldonkey/downloads.ini
[ -f /root/.mldonkey/users.ini ] && rm -f /root/.mldonkey/users.ini

[ ! -h /root/.mldonkey/downloads.ini ] && ln -s /datas/config/downloads.ini /root/.mldonkey/downloads.ini 
[ ! -h /root/.mldonkey/users.ini ] && ln -s /datas/config/users.ini /root/.mldonkey/users.ini

mldonkey -stdout -stderr
