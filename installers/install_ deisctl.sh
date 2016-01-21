#!/bin/sh

# install current version unless overridden by first command-line argument
VERSION=${1:-1.12.2}

# allow for an optional install location
if [ ! -z "$2" ] && [ -d "$2" ]; then
    INSTALLER_OPTS="--target $2"
fi

# try to detect Linux distribution family
OS=`hostnamectl status 2> /dev/null | sed -n -e 's/^.*Operating\ System: //p' | cut -d " " -f1`
if [ -z "$INSTALLER_OPTS" ] && [ "$OS" = "CoreOS" ]; then
    mkdir -p /opt/bin
    INSTALLER_OPTS="--target /opt/bin"
    INSTALL_GLOBAL_UNITS=true
fi

# catch errors from here on out
set -e

# determine from whence to download the installer
PLATFORM=`uname | tr '[:upper:]' '[:lower:]'`
DEIS_INSTALLER=${DEIS_INSTALLER:-deisctl-$VERSION-$PLATFORM-amd64.run}
DEIS_BASE_URL=${DEIS_BASE_URL:-https://s3-us-west-2.amazonaws.com/get-deis}
INSTALLER_URL=$DEIS_BASE_URL/$DEIS_INSTALLER

# download the installer archive to /tmp
curl -f -o /tmp/$DEIS_INSTALLER $INSTALLER_URL

# run the installer
sh /tmp/$DEIS_INSTALLER $INSTALLER_OPTS

# install the unit files to /var/lib/deis/units on CoreOS by default
if [ "$INSTALL_GLOBAL_UNITS" = "true" ]; then
    /opt/bin/deisctl refresh-units --path=/var/lib/deis/units --tag=v$VERSION
fi

# clean up after ourselves
rm -f /tmp/$DEIS_INSTALLER
