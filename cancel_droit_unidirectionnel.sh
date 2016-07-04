#!/bin/bash

context2=$1
context=$2

sed "/include => "$context"/d" /var/dialplan/$context2.conf > fichier.tmp && mv -f fichier.tmp /var/dialplan/$context2.conf; rm -f fichier.tmp

asterisk -rx "reload"