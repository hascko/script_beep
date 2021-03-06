#!/bin/bash

#Creation du dialplan
/bin/echo "[$1]" >> /var/dialplan/$1.conf                                                
/bin/echo "include => macro-voicemail" >> /var/dialplan/$1.conf
#/bin/echo "include => standard1" >> /var/dialplan/$1.conf
verif=`grep -w -n "\[standard1\]" /var/dialplan/standard.conf | cut -d":" -f1`
let verif++
sed ""$verif"i include => $1 " /var/dialplan/standard.conf > fichier.tmp && mv -f fichier.tmp /var/dialplan/standard.conf; rm -f fichier.tmp
/bin/echo "include => macro-conference_mdp" >> /var/dialplan/$1.conf
/bin/echo "include => macro-conference_smdp" >> /var/dialplan/$1.conf
/bin/echo "include => macro-conference_mdpt" >> /var/dialplan/$1.conf
/bin/echo "include => macro-conference_smdpt" >> /var/dialplan/$1.conf
/bin/echo "include => Queues" >> /var/dialplan/$1.conf
/bin/echo 'exten => 600,1,VoiceMailMain(${CALLERID(num)}@voicemail)' >> /var/dialplan/$1.conf
/bin/echo " " >> /var/dialplan/$1.conf

/bin/echo "#include \"/var/dialplan/$1.conf\"" >> /etc/asterisk/extensions.conf
/bin/echo "include => $1 " >> /var/dialplan/svi.conf

asterisk -rx "reload"