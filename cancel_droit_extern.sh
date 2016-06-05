#!/bin/bash

context=$1
extern=$2

verif=`grep -w -n "include => $extern" /var/dialplan/$context.conf | cut -d":" -f1`
sed ''$verif'd' /var/dialplan/$context.conf > fichier.tmp && mv -f fichier.tmp /var/dialplan/$context.conf; rm -f fichier.tmp

asterisk -rx "dialplan reload"