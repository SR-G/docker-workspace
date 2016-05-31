#!/bin/bash

# ========================================================
# === VARIABLES
# ========================================================

CONFIG_NAME="conf/openhab-bootstrap-config"
OPENHAB_DEST="/opt/openhab"
PATH_ADDONS="${OPENHAB_DEST}/addons/"
PATH_ADDONS_AVAILABLE="${OPENHAB_DEST}/addons-available/"
PATH_ADDONS_AVAILABLE_OH1="${OPENHAB_DEST}/addons-available-oh1/"
OPENHAB_URL_RELEASES="https://bintray.com/artifact/download/openhab/bin" 
OPENHAB2_URL_SNAPSHOTS="https://openhab.ci.cloudbees.com/job/openHAB-Distribution/lastSuccessfulBuild/artifact/distributions/openhab-offline/target/"
PIPEWORK_URL="https://raw.githubusercontent.com/jpetazzo/pipework/master/pipework"

# ========================================================
# === FUNCTIONS
# ========================================================

function step {
	echo "==== $1"
}

function installOpenHAB {
	OPENHAB_VERSION="$1"
	step "Installing OpenHAB version [${OPENHAB_VERSION}]"
	IS_SNAPSHOT=$(echo "$OPENHAB_VERSION"|grep "SNAPSHOT"|wc -l)
	if [[ "$IS_SNAPSHOT" -eq 1 ]] ; then
		OPENHAB_URL="${OPENHAB2_URL_SNAPSHOTS}openhab-offline-${OPENHAB_VERSION}.zip"
	else
		OPENHAB_URL="${OPENHAB_URL_RELEASES}openhab-offline-${OPENHAB_VERSION}.zip"
	fi
	step "Downloading [${OPENHAB_URL}]"
	curl -sLo "${OPENHAB_DEST}/openhab.zip" "${OPENHAB_URL}"
	step "Unzipping ..."
	unzip -q "${OPENHAB_DEST}/openhab.zip" -d "${OPENHAB_DEST}/tmp"
	rm -rf "${OPENHAB_DEST}/tmp/conf" 
	mv "${OPENHAB_DEST}/tmp/"* "${OPENHAB_DEST}/"
	rm -rf "${OPENHAB_DEST}/tmp" "${OPENHAB_DEST}/openhab.zip" >/dev/null 2>&1
	rm "${OPENHAB_DEST}/"*.bat "${OPENHAB_DEST}/"*.txt "${OPENHAB_DEST}/"*.TXT >/dev/null 2>&1
	find "${OPENHAB_DEST}" -name "README.*" -exec rm '{}' \;
}

function installSigar {
	SIGAR_VERSION="$1"
	step "Installing SIGAR version [$SIGAR_VERSION]"
	SIGAR_URL="http://sourceforge.net/projects/sigar/files/sigar/1.6/hyperic-sigar-${SIGAR_VERSION}.tar.gz/download"
	SIGAR_DIR="${OPENHAB_DEST}/runtime/karaf/lib/"
	SIGAR_TGZ="${SIGAR_DIR}/sigar.tgz"
	SIGAR_SO="libsigar-amd64-linux.so"
	if [[ ! -f "${SIGAR_DIR}/${SIGAR_SO}" ]] ; then
	  [[ ! -d "${SIGAR_DIR}" ]] && mkdir "${SIGAR_DIR}"
	  step "downloading SIGAR from ${SIGAR_URL}"
	  curl -sLo "${SIGAR_TGZ}" "${SIGAR_URL}" 
	  step "installing in ${SIGAR_DIR}"
	  tar --extract --file="${SIGAR_TGZ}" --directory "${SIGAR_DIR}" --no-anchored --transform 's/.*\///' "${SIGAR_SO}"
	  rm "${SIGAR_TGZ}"
	fi
	ls -Al "${SIGAR_DIR}"
}

function installHabMin {
	HABMIN_VERSION="$1"
	step "Installing HABmin version [$HABMIN_VERSION]"
	# https://github.com/cdjackson/HABmin2/blob/master/output/org.openhab.ui.habmin_2.0.0.SNAPSHOT-0.1.6.jar
	# https://github.com/cdjackson/HABmin2/releases/download/0.1.5/org.openhab.ui.habmin_2.0.0.201605241605.jar
	HABMIN_URL="https://github.com/cdjackson/HABmin2/raw/master/output/org.openhab.ui.habmin_${HABMIN_VERSION}.jar"
	mkdir -p "${PATH_ADDONS_AVAILABLE}"
	curl -sLo "${PATH_ADDONS_AVAILABLE}/org.openhab.ui.habmin-${HABMIN_VERSION}.jar" "${HABMIN_URL}"
}

function restoreAddons {
	step "Restoring addons"
	for P in ${PATH_ADDONS_AVAILABLE} ${PATH_ADDONS_AVAILABLE_OH1} ; do
		cat "${CONFIG_NAME}" | grep "^ADDON " | while read A ADDON DUMMY ; do
		  FOUND_ADDON=$(ls -1 ${P}/*${ADDON}* 2>/dev/null | tail -1)
		  if [[ ! -z "$FOUND_ADDON" ]] ; then
			echo "Activating module [$ADDON] from [$P]"
			ln -s "$FOUND_ADDON" "$PATH_ADDONS"
		  fi    
		done
	done

	echo "Activated addons : "
	ls -1 "${PATH_ADDONS}"*.jar
}

function installOpenHAB1Addons {
	OPENHAB1_VERSION="$1"
	step "Restoring addons from OpenHAB [$OPENHAB1_VERSION]"
	mkdir -p ${PATH_ADDONS_AVAILABLE_OH1}
	IS_SNAPSHOT=$(echo "$OPENHAB1_VERSION"|grep "SNAPSHOT"|wc -l)
        if [[ "$IS_SNAPSHOT" -eq 1 ]] ; then
                OPENHAB1_URL="${OPENHAB2_URL_SNAPSHOTS}" # todo
        else
                OPENHAB1_URL="${OPENHAB_URL_RELEASES}"
        fi
	for ITEM in addons runtime ; do
		P="distribution-${OPENHAB1_VERSION}-${ITEM}.zip"
		curl -sLo /tmp/$P "${OPENHAB1_URL}${P}"
	done
	unzip -q /tmp/distribution-${OPENHAB1_VERSION}-addons.zip -d ${PATH_ADDONS_AVAILABLE_OH1}
	unzip -j /tmp/distribution-${OPENHAB1_VERSION}-runtime.zip server/plugins/org.openhab.io.transport.mqtt* -d ${PATH_ADDONS_AVAILABLE_OH1}
	unzip -j /tmp/distribution-${OPENHAB1_VERSION}-runtime.zip configurations/openhab_default.cfg -d /opt/openhab/
	# rm -f /opt/openhab/runtime/server/plugins/org.openhab.io.transport.mqtt*
	rm /tmp/*.zip
}

function installPipework {
	mkdir -p /opt/pipework 
	curl -sLo /opt/pipework/pipework "{PIPEWORK_URL}"
	chmod a+x /opt/pipework/pipework
}

# ========================================================
# === MAIN EXECUTION
# ========================================================

ACTION="$1"
case "$ACTION" in
  "install-openhab2") installOpenHAB "$2" ;;
  "install-sigar") installSigar "$2" ;;
  "install-habmin") installHabMin "$2" ;;
  "install-openhab1-addons") installOpenHAB1Addons "$2" ;;
  "install-pipework") installPipework ;;
  "restore-addons") restoreAddons ;;
  *) echo "Unknown command, available commands : install-openhab2 <version>, install-sigar <version>, install-habmin <version>, install-openhab1-addons <version>, install-pipework, restore-addons" 
esac
