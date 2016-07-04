#!/bin/bash

compte=$1
host=$2
port=$3
groupe=$4
old_switch=$5
new_switch=$6

verif=`grep -w -n 'exten => _'$old_switch'.,1,Dial(SIP\/outgoing\_'$compte'\_'$host'\_'$port'\/\${EXTEN}) ;' /var/dialplan/$groupe.conf | cut -d":" -f1`

sed ""$verif"c exten => _"$new_switch".,1,Dial(SIP\/outgoing_"$compte"_"$host"_"$port"\/\${EXTEN}) ;" /var/dialplan/$groupe.conf > fichier.tmp && mv -f fichier.tmp /var/dialplan/$groupe.conf; rm -f fichier.tmp

asterisk -rx "reload"