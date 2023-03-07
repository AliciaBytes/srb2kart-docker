#!/bin/sh

cd /srb2kart || exit

ADDONS=$(ls /addons)

if [ -n "$ADDONS" ]; then
    ADDONS="-file ${ADDONS}"
fi

# shellcheck disable=SC2086
/usr/bin/srb2kart -dedicated -home data $ADDONS
