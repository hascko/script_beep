#!/bin/bash

context2=$1
context=$2

sed "1i#include /var/dialplan/$context.conf" /var/dialplan/$context2.conf > fichier.tmp && mv -f fichier.tmp /var/dialplan/$context2.conf; rm -f fichier.tmp
sed "1i#include /var/dialplan/$context2.conf" /var/dialplan/$context.conf > fichier.tmp && mv -f fichier.tmp /var/dialplan/$context.conf; rm -f fichier.tmp
echo "include => $context2" >> /var/dialplan/$context.conf
echo "include => $context" >> /var/dialplan/$context2.conf

asterisk -rx "dialplan reload"