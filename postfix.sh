#!/bin/sh

# Disable SMTPUTF8, because libraries (ICU) are missing in alpine
postconf -e smtputf8_enable=no

if [[ $RELAY_HOST != '' ]]; then
    postconf -e relayhost=$RELAY_HOST
fi

if [[ $ALWAYS_BCC != '' ]]; then
    postconf -e always_bcc=$ALWAYS_BCC
fi

if [[ $HEADER_CHECKS != '' ]]; then
    postconf -e header_checks=$HEADER_CHECKS
fi

if [[ $MSG_SIZE_LIMIT != '' ]]; then
    postconf -e message_size_limit=$MSG_SIZE_LIMIT
fi
