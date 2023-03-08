#!/bin/sh

cd /srb2kart || exit

if [ -n "$BANDWIDTH" ]; then
    BANDWIDTH="-bandwidth $BANDWIDTH"
fi

if [ -n "$BINDADDR" ]; then
    BINDADDR="-bindaddr $BINDADDR"
fi

if [ -n "$BINDADDR6" ] && [ -n "$IPV6" ]; then
    BINDADDR6="-bindaddr6 $BINDADDR6"
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

# shellcheck disable=SC2086
/usr/bin/srb2kart -dedicated -home data \
    $BANDWIDTH $BINDADDR $BINDADDR6 $EXTRATIC $IPV6 $PACKETSIZE $SERVERPORT $USEUPNP $ADDONS
