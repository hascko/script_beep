#!/bin/bash

context=$1
extern=$2

verif=`grep -w "\#include /var/dialplan/extern.conf" /var/dialplan/$context.conf`
if [ "$verif" == "" ];then
sed "1i#include /var/dialplan/extern.conf" /var/dialplan/$context.conf > fichier.tmp && mv -f fichier.tmp /var/dialplan/$context.conf; rm -f fichier.tmp
fi
echo "include => $extern" >> /var/dialplan/$context.conf

asterisk -rx "reload"