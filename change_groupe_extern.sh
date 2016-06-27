#!/bin/bash

nom_groupe_extern=$1

switchs=`grep -w "\;$nom_groupe_extern" /var/dialplan/extern.conf`
echo $switchs > file.tmp
sed -i -e "s/$nom_groupe_extern//g" file.tmp

set -a tableau
part="depart"
i=0
while [ ! -z "$part" ]
do
        part=`grep "exten" file.tmp | cut -d";" -f$((i + 1))`
        if [ ! -z "$part" ];then
                echo $i
                tableau[$i]=$part
                let i++
        fi
done

taille=${#tableau[@]}
i=0
verif=`grep -w -n "\[default\]" /var/dialplan/extern.conf | cut -d":" -f1`
let verif++

while [ "$taille" -gt "$i" ]
do
sed ""$verif"i ${tableau[$i]}" /var/dialplan/extern.conf > fichier.tmp && mv -f fichier.tmp /var/dialplan/extern.conf; rm -f fichier.tmp
let i++
done

sed -i "/\;$nom_groupe_extern/d" /var/dialplan/extern.conf
sed -i "/\[$nom_groupe_extern\]/d" /var/dialplan/extern.conf

asterisk -rx "dialplan reload"