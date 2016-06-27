#!/bin/bash

compte=$1
host=$2
port=$3
groupe=$4
switch=$5

sed "/exten => _"$switch".,1,Dial(SIP\/outgoing_"$compte"_"$host"_"$port"\/\${EXTEN})/d" /var/dialplan/$groupe.conf > fichier.tmp && mv -f fichier.tmp /var/dialplan/$groupe.conf; rm -f fichier.tmp

asterisk -rx "dialplan reload"