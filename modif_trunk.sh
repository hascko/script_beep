#!/bin/bash

compte=$1
mdp=$2

verif=`grep -w -n "\;$compte" /var/user/general.conf | cut -d":" -f1`
let verif++
host=`grep -w "register => $compte" /var/user/general.conf | cut -d"@" -f2`
port=`grep -w "register => $compte" /var/user/general.conf | cut -d":" -f3`
sed ""$verif"c register => $compte:$mdp@$host:$port" /var/user/general.conf > fichier.tmp && mv -f fichier.tmp /var/user/general.conf; rm -f fichier.tmp

verif2=`grep -w -n "username=$compte" /var/user/ippi.conf | cut -d":" -f1`
let verif2++
sed ""$verif2"c secret=$mdp" /var/user/ippi.conf > fichier.tmp && mv -f fichier.tmp /var/user/ippi.conf; rm -f fichier.tmp

asterisk -rx "sip reload"
asterisk -rx "dialplan reload"