#!/bin/bash

compte=$1
host=$2
port=$3
groupe=$4
switch=$5

verif=`grep -w "\[$groupe\]" /var/dialplan/extern.conf`

if [ "$verif" == "" ];then
        echo "[$groupe]" >> /var/dialplan/extern.conf
        echo "exten => _$switch.,1,Dial(SIP/outgoing_"$compte"_"$host"_"$port"/\${EXTEN}) ;$groupe" >> /var/dialplan/extern.conf
else
        verif=`grep -w -n "\[$groupe\]" /var/dialplan/extern.conf | cut -d":" -f1`
        let verif++
        sed ""$verif"i exten => _"$switch".,1,Dial(SIP/outgoing_"$compte"_"$host"_"$port"/\${EXTEN}) ;$groupe" /var/dialplan/extern.conf > fichier.tmp && mv -f fichier.tmp /var/dialplan/extern.conf; rm -f fichier.tmp
fi

asterisk -rx "dialplan reload"