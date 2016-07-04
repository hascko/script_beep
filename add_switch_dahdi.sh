#!/bin/bash

groupe=$1
switch=$2

echo "exten => _$switch.,1,Dial(DAHDI/4/\${EXTEN}) ;" >> /var/dialplan/$groupe.conf

asterisk -rx "reload"