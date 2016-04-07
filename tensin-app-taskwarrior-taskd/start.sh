#!/bin/bash

# TODO externalizse
[[ -z "$ORGS" ]] && ORGS="tensin"
[[ -z "$GROUPS" ]] && GROUPS="users"
[[ -z "$USERS" ]] && USERS="srg"
[[ -z "$TASKWARRIOR_HOSTNAME" ]] && TASKWARRIOR_HOSTNAME="0.0.0.0"

[[ ! -d $TASKWARRIOR_DATA ]] && mkdir -p $TASKWARRIOR_DATA
[[ ! -d $TASKWARRIOR_KEYS ]] && mkdir -p $TASKWARRIOR_KEYS
export TASKDDATA=$TASKWARRIOR_DATA
chmod 600 $TASKWARRIOR_DATA $TASKWARRIOR_KEYS
ls -Al $TASKWARRIOR_KEYS | wc -l | read NB_KEYS
if [[ "$NB_KEYS" -eq 0 ]] ; then
  echo "Init $TASKWARRIOR_DATA"
  taskd init --data $TASKWARRIOR_DATA 
  echo "Generating keys"
  cd /opt/taskd/pki/
  ./generate
  for KEY in client.cert client.key server.cert server.key server.crl ca.cert ; do
    echo "Registering $KEY"
    cp $KEY.pem $TASKWARRIOR_KEYS
    taskd config --data $TASKWARRIOR_DATA --force $KEY $TASKWARRIOR_KEYS/$KEY.pem
  done
  cp ca.key.pem $TASKWARRIOR_KEYS

  taskd config --data $TASKWARRIOR_DATA --force log /dev/stdout
  taskd config --data $TASKWARRIOR_DATA --force server $TASKWARRIOR_HOSTNAME:$TASKWARRIOR_PORT
  taskd config --data $TASKWARRIOR_DATA --force client.allow '^task [2-9],^taskd,^libtaskd,^Mirakel [1-9]'

  for ORG in $ORGS ; do
    taskd add --data $TASKWARRIOR_DATA org $ORG
  done

  for GROUP in $GROUPS ; do
    taskd add --data $TASKWARRIOR_DATA group $ORG $GROUP
  done

  mkdir -p $TASKWARRIOR_KEYS/users/ >/dev/null 2>&1
  for USER in $USERS ; do
    R=$(taskd add --data $TASKWARRIOR_DATA user $ORG $USER | head -1 | awk ' { print $4 } ')
    ./generate.client $USER
    cp $USER.* $TASKWARRIOR_KEYS/users/
    echo "$R" > $TASKWARRIOR_KEYS/users/$USER.key
  done

fi

taskd server --data $TASKWARRIOR_DATA
