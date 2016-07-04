#!/bin/bash

nom_groupe_extern=$1

switchs=`grep -w "exten" /var/dialplan/$nom_groupe_extern.conf`
echo $switchs > file.tmp

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

while [ "$taille" -gt "$i" ]
do
echo  ${tableau[$i]} >> /var/dialplan/default_extern.conf
let i++
done

sed -i "/exten/d" /var/dialplan/$nom_groupe_extern.conf
sed /$nom_groupe_extern.conf/d /etc/asterisk/extensions.conf > /var/tmp/temp
mv /var/tmp/temp /etc/asterisk/extensions.conf
rm /var/dialplan/$nom_groupe_extern.conf

asterisk -rx "reload"