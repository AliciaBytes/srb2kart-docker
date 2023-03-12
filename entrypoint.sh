#!/bin/sh

cd /srb2kart || exit

if [ -n "$BANDWIDTH" ]; then
    BANDWIDTH="-bandwidth $BANDWIDTH"
fi

if [ -n "$EXTRATIC" ]; then
    EXTRATIC="-extratic $EXTRATIC"
fi

if [ -n "$IPV6" ]; then
    IPV6="-ipv6"
fi

if [ -n "$PACKETSIZE" ]; then
    PACKETSIZE="-packetsize $PACKETSIZE"
fi

if [ -n "$SERVERPORT" ]; then
    SERVERPORT="-serverport $SERVERPORT"
fi

if [ -n "$USEUPNP" ]; then
    USEUPNP="-useuPnP"
fi

ADDONS=$(ls /addons)

if [ -n "$ADDONS" ]; then
    ADDONS="-file ${ADDONS}"
fi

cd /srb2kart/data || exit

# shellcheck disable=SC2086
/usr/bin/srb2kart -dedicated -home /srb2kart/data \
    $BANDWIDTH $BINDADDR $BINDADDR6 $EXTRATIC $IPV6 $PACKETSIZE $SERVERPORT $USEUPNP "$@" $ADDONS
