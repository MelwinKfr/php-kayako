#!/bin/sh

if [[ $RELAY_HOST != '' ]]; then
    postconf -e relayhost=$RELAY_HOST
fi

if [[ $ALWAYS_BCC != '' ]]; then
    postconf -e always_bcc=$ALWAYS_BCC
fi

if [[ $HEADER_CHECKS != '' ]]; then
    postconf -e header_checks=$HEADER_CHECKS
fi
