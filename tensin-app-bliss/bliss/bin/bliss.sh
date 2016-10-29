#!/bin/bash
# 
# Shell script to run bliss

INSTALL_HOME=`dirname "$0"`/..

JAVA_EXEC=java
if [ -e "${JAVA_HOME}" ] 
then 
JAVA_EXEC=${JAVA_HOME}/bin/java 
fi

if [ -z "${BLISS_MAX_HEAP}" ]
then
BLISS_MAX_HEAP=128M
fi

if [ -z "${BLISS_HEAP_DUMP_PATH}" ]
then
BLISS_HEAP_DUMP_PATH=/tmp
fi

if [ -z "${BLISS_OSGI_BUNDLE_STORAGE}" ]
then
BLISS_OSGI_BUNDLE_STORAGE=${INSTALL_HOME}/felix-cache
fi

if [ -z "${BLISS_JAVA_LOGGING_CONFIG_FILE}" ]
then
BLISS_JAVA_LOGGING_CONFIG_FILE=${INSTALL_HOME}/conf/logging.properties
fi

if [ -z "${BLISS_RUN_MODE}" ]
then
BLISS_RUN_MODE=production
fi

# If BLISS_LAUNCHER_PROPERTY is set to an empty string, it won't be passed to bliss, meaning
# the updater won't attempt to restart bliss after an update.
if [ -z "${BLISS_LAUNCHER_PROPERTY+set}" ]
then
BLISS_LAUNCHER_PROPERTY=-Dbliss.launcher="$0"
fi

exec ${JAVA_EXEC} ${VMARGS} -Xmx${BLISS_MAX_HEAP} -splash:bliss-splash.png -XX:HeapDumpPath=${BLISS_HEAP_DUMP_PATH} -XX:+HeapDumpOnOutOfMemoryError -XX:+CMSClassUnloadingEnabled -Djava.awt.headless=true -Djava.util.logging.config.file=${BLISS_JAVA_LOGGING_CONFIG_FILE} -Djava.library.path=${INSTALL_HOME}/lib -Dbliss.periodicHeapDumpThreshold=0.9 -Dorg.osgi.framework.storage=${BLISS_OSGI_BUNDLE_STORAGE} -Dfelix.auto.deploy.dir=${INSTALL_HOME}/bundle -Dbliss.bootstrapbundle.initialbundledir=${INSTALL_HOME}/bliss-bundle ${BLISS_LAUNCHER_PROPERTY} -Drun.mode=${BLISS_RUN_MODE} -jar ${INSTALL_HOME}/bin/felix.jar "$@"
