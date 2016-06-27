#!/bin/bash

nom_groupe_extern=$1

echo "[$nom_groupe_extern]" >> /var/dialplan/extern.conf

asterisk -rx "dialplan reload"