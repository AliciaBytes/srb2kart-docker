#!/bin/sh

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

if [ -n "$ROOM_ID" ]; then
    ROOM_ID="-room $ROOM_ID"
fi

if [ -n "$SERVERPORT" ]; then
    SERVERPORT="-serverport $SERVERPORT"
fi

if [ -n "$USEUPNP" ]; then
    USEUPNP="-useuPnP"
fi

if [ -n "$WARP" ]; then
    WARP="-warp $WARP"
fi

ADDONS=$(ls /addons)

if [ -n "$ADDONS" ]; then
    ADDONS="-file ${ADDONS}"
fi

# shellcheck disable=SC2086
/usr/bin/srb2kart -dedicated -home /srb2kart/data -config /srb2kart/data/config.cfg \
    $BANDWIDTH $BINDADDR $BINDADDR6 $EXTRATIC $IPV6 $PACKETSIZE $ROOM_ID $SERVERPORT $USEUPNP $WARP "$@" $ADDONS
