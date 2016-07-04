#!/bin/bash

compte=$1
new_mdp=$2
host=$3
port=$4
mdp=$5

verif=`grep -w -n "\;$compte\_$host\_$port" /var/user/general.conf | cut -d":" -f1`
let verif++
host=`grep -w -n "register => $compte\:$mdp\@$host\:$port" /var/user/general.conf | cut -d"@" -f2 | cut -d":" -f1`
port=`grep -w -n "register => $compte\:$mdp\@$host\:$port" /var/user/general.conf | cut -d"@" -f2 | cut -d":" -f2`
sed ""$verif"c register => $compte:$new_mdp@$host:$port" /var/user/general.conf > fichier.tmp && mv -f fichier.tmp /var/user/general.conf; rm -f fichier.tmp

verif2=`grep -w -n "\;$compte\_$host\_$port" /var/user/ippi.conf | cut -d":" -f1`
verif2=$((verif + 5))
sed ""$verif2"c secret=$new_mdp" /var/user/ippi.conf > fichier.tmp && mv -f fichier.tmp /var/user/ippi.conf; rm -f fichier.tmp

asterisk -rx "reload"