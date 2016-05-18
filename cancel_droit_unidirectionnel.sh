#!/bin/bash

user=$1
context=$2

verif=`find /var/user/$user.conf 2>/dev/null`

if [ -z "$verif" ];then
        echo "$user n'existe pas"
else
        context2=`grep -n "context" "/var/user/$user.conf" | cut -d"=" -f2`
        sed -i "/$context.conf/d" /var/dialplan/$context2.conf
        sed -i "/$context/d" /var/dialplan/$context2.conf
fi

asterisk -rx "dialplan reload"