#!/bin/bash

nom_groupe_extern=$1

touch /var/dialplan/$nom_groupe.conf

echo "[$nom_groupe_extern]" >> /var/dialplan/$nom_groupe_extern.conf

echo "#include \"/var/dialplan/$nom_groupe_extern.conf\"" >> /etc/asterisk/extensions.conf

asterisk -rx "dialplan reload"