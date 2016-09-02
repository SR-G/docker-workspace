#!/bin/sh

# Documentation here : http://manual.seafile.com/deploy/common_problems_for_setting_up_server.html

SEAFILE_VERSION=6.0.2
SEAFILE_ARCHIVE_URL="https://bintray.com/artifact/download/seafile-org/seafile/seafile-server_${SEAFILE_VERSION}_x86-64.tar.gz"

cd /opt/seafile
curl -L -O "$SEAFILE_ARCHIVE_URL"
tar xzf seafile-server_*
mkdir -p installed
mv seafile-server_* installed
