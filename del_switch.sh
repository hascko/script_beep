#!/bin/bash

compte=$1
host=$2
port=$3
groupe=$4
switch=$5

sed "/exten => _"$switch".,1,Dial(SIP\/outgoing_"$compte"_"$host"_"$port"\/\${EXTEN}) ;"$groupe"/d" /var/dialplan/extern.conf > fichier.tmp && mv -f fichier.tmp /var/dialplan/extern.conf; rm -f fichier.tmp

#/exten => _30.,1,Dial(SIP\/outgoing_zalika_inter_ippi.fr_5060\/\${EXTEN}) ;extern1/
asterisk -rx "dialplan reload"