#!/bin/bash

arg=$#
if [ $# == 2 ]
        then
                sed -i -e "/include => $1 /d" /var/dialplan/$2.conf
                sed /$1.conf/d /etc/asterisk/extensions.conf > /var/tmp/temp
                mv /var/tmp/temp /etc/asterisk/extensions.conf
                rm /var/dialplan/$1.conf
fi
