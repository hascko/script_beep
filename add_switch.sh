#!/bin/bash

compte=$1
host=$2
port=$3
groupe=$4
switch=$5

echo "exten => _$switch.,1,Dial(SIP/outgoing_"$compte"_"$host"_"$port"/\${EXTEN}) ;" >> /var/dialplan/$groupe.conf

asterisk -rx "dialplan reload"