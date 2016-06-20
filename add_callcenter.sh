#!/bin/bash

nom_call=$1
strategy=$2
numero_call=$3

echo ";$nom_call" >> /etc/asterisk/queues.conf
echo "[$nom_call]" >> /etc/asterisk/queues.conf
echo "strategy=$strategy" >> /etc/asterisk/queues.conf
echo ";fin $nom_call" >> /etc/asterisk/queues.conf

echo ";$nom_call" >> /var/dialplan/callcenter.conf
echo "exten => $numero_call,1,Verbose(2,\${CALLERID(all)} entering the $nom_call queue)" >> /var/dialplan/callcenter.conf
echo "same => n,Queue($nom_call)" >> /var/dialplan/callcenter.conf
echo "same => n,Hangup()" >> /var/dialplan/callcenter.conf
echo ";fin $nom_call" >> /var/dialplan/callcenter.conf

asterisk -rx "module reload app_queue.so"