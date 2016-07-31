#!/bin/bash

# ========================================================
# === VARIABLES
# ========================================================

DATE=$(date "+%Y-%m-%d")
CONFIG_NAME="data/openhab-bootstrap-config"
NEW_VERSION="$1"
SNAPSHOTS="0"
OPENHAB_VERSION="$1"
OPENHAB_RUNTIME="runtime"
OPENHAB_DISTRIBUTION="zips/"
PATH_ADDONS_ACTIVATED="${NEW_VERSION}/${OPENHAB_RUNTIME}/addons/"
PATH_ADDONS_DEACTIVATED="${NEW_VERSION}/${OPENHAB_RUNTIME}/addons-deactivated/"


# ========================================================
# === FUNCTIONS
# ========================================================

function usage {
	echo "Usage : $0 <new_version>" && exit 1
}

function checkPrerequesites {
	[[ -z "$NEW_VERSION" ]] && usage
	[[ $(echo "${NEW_VERSION}" | grep "SNAPSHOT" | wc -l) -eq 1 ]] && SNAPSHOTS="1" && NEW_VERSION="${NEW_VERSION}-${DATE}"
	[[ -d "${NEW_VERSION}" ]] && echo "New version [${NEW_VERSION}] already exists, please remove it manually if needed" && exit 0
	mkdir -m 775 "${NEW_VERSION}"
}	

function step {
	echo "==== $1"
}

function substep {
	echo "  . $1"
}

function installNewSnapshot {
	step "Installing new SNAPSHOT in [${NEW_VERSION}]"
	OPENHAB_URL_SNAPSHOTS="https://openhab.ci.cloudbees.com/job/openHAB/lastSuccessfulBuild/artifact/distribution/target/"
	OPENHAB_URL_RELEASES="https://bintray.com/artifact/download/openhab/bin" 
	if [[ "$SNAPSHOT" -eq 1 ]] ; then
		OPENHAB_URL="${OPENHAB_URL_SNAPSHOTS}"
	else
		OPENHAB_URL="${OPENHAB_URL_RELEASES}"
	fi
	rm -f "${OPENHAB_DISTRIBUTION}/"*
	[[ ! -d "${OPENHAB_DISTRIBUTION}" ]] && mkdir "${OPENHAB_DISTRIBUTION}"
	cat "${CONFIG_NAME}" | grep "^PACKAGE" | while read C ITEM DEST DUMMY ; do
		OPENHAB_ITEM="distribution-${OPENHAB_VERSION}-${ITEM}.zip"
		substep "Downloading [$ITEM] from [${OPENHAB_URL}/${OPENHAB_ITEM}]"
		curl -sLo "${OPENHAB_DISTRIBUTION}/${OPENHAB_ITEM}" "${OPENHAB_URL}/${OPENHAB_ITEM}"
		substep "Unzipping [$ITEM]"
		[[ ! -d "${NEW_VERSION}/${DEST}" ]] && mkdir -p "${NEW_VERSION}/${DEST}"
		unzip -o -q "${OPENHAB_DISTRIBUTION}/${OPENHAB_ITEM}" -d "${NEW_VERSION}/${DEST}"
		rm "${OPENHAB_DISTRIBUTION}/${OPENHAB_ITEM}" >/dev/null 2>&1
	done
}

function installSigar {
	step "Installing SIGAR"
	SIGAR_URL="http://sourceforge.net/projects/sigar/files/sigar/1.6/hyperic-sigar-1.6.4.tar.gz/download"
	SIGAR_DIR="${NEW_VERSION}/${OPENHAB_RUNTIME}/lib"
	SIGAR_TGZ="${SIGAR_DIR}/sigar.tgz"
	SIGAR_SO="libsigar-amd64-linux.so"
	if [[ ! -f "${SIGAR_DIR}/${SIGAR_SO}" ]] ; then
	  [[ ! -d "${SIGAR_DIR}" ]] && mkdir "${SIGAR_DIR}"
	  substep "downloading SIGAR from ${SIGAR_URL}"
	  curl -sLo "${SIGAR_TGZ}" "${SIGAR_URL}" 
	  substep "installing in ${SIGAR_DIR}"
	  tar --extract --file="${SIGAR_TGZ}" --directory "${SIGAR_DIR}" --no-anchored --transform 's/.*\///' "${SIGAR_SO}"
	  rm "${SIGAR_TGZ}"
	fi
	ls -Al "${SIGAR_DIR}"
}

function installHabMin {
	step "Installing HABmin"
	HABMIN_URL="https://github.com/cdjackson/HABmin/archive/master.zip"
	substep "Downloading [habmin]"
	curl -sLo "${OPENHAB_DISTRIBUTION}/habmin-master.zip" "${HABMIN_URL}"
	substep "Unzipping [habmin]"
	unzip -o -q "${OPENHAB_DISTRIBUTION}/habmin-master.zip" -d "${NEW_VERSION}/habmin/"
	cp "${NEW_VERSION}/habmin/HABmin-master/addons/"*.jar "${PATH_ADDONS_ACTIVATED}"
	rm -rf "${NEW_VERSION}/habmin/HABmin-master/addons/"
	# ln -s "../../habmin/HABmin-master/" "${NEW_VERSION}/${OPENHAB_RUNTIME}/webapps/habmin"
	mv "${NEW_VERSION}/habmin/HABmin-master/" "${NEW_VERSION}/${OPENHAB_RUNTIME}/webapps/habmin"
	rm -rf "${NEW_VERSION}/habmin/"
}

function restoreTwitterToken {
	step "Restoring twitter token"
	cp "${OLD_VERSION}/${OPENHAB_RUNTIME}/etc/twitter.token" "${NEW_VERSION}/${OPENHAB_RUNTIME}/etc/"
}

function restoreAddons {
	step "Restoring addons"
	[[ ! -d "$PATH_ADDONS_DEACTIVATED" ]] && mkdir -p -m 775 "$PATH_ADDONS_DEACTIVATED"
	mv "$PATH_ADDONS_ACTIVATED/"*.jar "$PATH_ADDONS_DEACTIVATED" >/dev/null 2>&1
	cat "${CONFIG_NAME}" | grep "^ADDON" | while read A ADDON DUMMY ; do
	  FOUND_ADDON=$(ls -1 ${PATH_ADDONS_DEACTIVATED}/*${ADDON}* 2>/dev/null | tail -1)
	  if [[ ! -z "$FOUND_ADDON" ]] ; then
		echo "Activating module [$ADDON]"
		mv "$FOUND_ADDON" "$PATH_ADDONS_ACTIVATED"
	  fi    
	done

	echo "\nDeactivated addons : "
	ls -1 "${PATH_ADDONS_DEACTIVATED}"*.jar

	echo ""
	echo "\nActivated addons : "
	ls -1 "${PATH_ADDONS_ACTIVATED}"*.jar
}

function cleaUselessFiles {
	step "Post-cleaning"
	rm "${NEW_VERSION}/${OPENHAB_RUNTIME}/"*.bat >/dev/null 2>&1
	rm "${NEW_VERSION}/${OPENHAB_RUNTIME}/"*.txt >/dev/null 2>&1
	rm "${NEW_VERSION}/${OPENHAB_RUNTIME}/"*.TXT >/dev/null 2>&1
	find "${NEW_VERSION}/${OPENHAB_RUNTIME}" -name "README.*" -exec rm '{}' \;
}

function postDownload {
	step "Installing additionnal icons"
	# curl -sLo "${NEW_VERSION}/${OPENHAB_RUNTIME}/webapps/images/plugwise.png" "http://icon.downv.com/32x32/13/403/3201145.8c8db74d23fc9347e55489da1b3f9366.jpg"
	# curl -sLo "${NEW_VERSION}/${OPENHAB_RUNTIME}/webapps/images/hue.png" "http://www.developers.meethue.com/otherapps/imagesAndroid/aojTkxmDGqEHMnpAk2_j1osUflvIKp8lChLCgQEqZsZgbK8WihwDcCiiOHRKKG_d6DT1=w300.png" 
	# curl -sLo "${NEW_VERSION}/${OPENHAB_RUNTIME}/webapps/images/wol.png" "http://icons.iconarchive.com/icons/dakirby309/windows-8-metro/32/Other-Power-Restart-Metro-icon.png" 
	cp /opt/openhab/data/images/* "${NEW_VERSION}/${OPENHAB_RUNTIME}/webapps/images/"

	step "Restoring UUID"
	cp -R /opt/openhab/data/static "${NEW_VERSION}/${OPENHAB_RUNTIME}/webapps/"

	step "Installing myopenhab addon"
	# curl -sLo "${NEW_VERSION}/${OPENHAB_RUNTIME}/addons/org.openhab.io.myopenhab-1.4.0-SNAPSHOT.jar" "https://my.openhab.org/downloads/org.openhab.io.myopenhab-1.4.0-SNAPSHOT.jar"
	cp /opt/openhab/data/addons/* "${NEW_VERSION}/${OPENHAB_RUNTIME}/addons/"

	step "Chmoding shells"
	chmod a+x "${NEW_VERSION}/${OPENHAB_RUNTIME}/"*.sh
}

function restoreSymLinks {
	step "Restoring symlinks for configurations/ and etc/"
	rm -rf "${NEW_VERSION}/${OPENHAB_RUNTIME}/configurations/"
	rm -rf "${NEW_VERSION}/${OPENHAB_RUNTIME}/etc/"
	ln -s "/opt/openhab/data/configurations" "${NEW_VERSION}/${OPENHAB_RUNTIME}/configurations"
	ln -s "/opt/openhab/data/etc" "${NEW_VERSION}/${OPENHAB_RUNTIME}/etc"
	ln -s "/var/log/openhab" "${NEW_VERSION}/${OPENHAB_RUNTIME}/logs"
}

# ========================================================
# === MAIN EXECUTION
# ========================================================

[[ "$#" -ne 1 ]] && usage 
checkPrerequesites
[[ ! -d "$PATH_ADDONS_ACTIVATED" ]] && mkdir -p -m 775 "$PATH_ADDONS_ACTIVATED"
echo "$(date) - Will now install new version [$NEW_VERSION]"
installNewSnapshot 
installSigar
installHabMin
restoreAddons
restoreSymLinks
cleaUselessFiles
postDownload
step "$(date) - End."
