#!/bin/bash

nom_call=$1
new_strategy=$2

verif=`grep -w -n "\[$nom_call\]" /etc/asterisk/queues.conf | cut -d":" -f1`
let verif++
sed ""$verif"c strategy="$new_strategy"" /etc/asterisk/queues.conf > fichier.tmp && mv -f fichier.tmp /etc/asterisk/queues.conf; rm -f fichier.tmp

asterisk -rx "module reload app_queue.so"