#!/bin/bash

nom_call=$1

sed -i "/\;$nom_call/,/\;fin $nom_call/d" /etc/asterisk/queues.conf

asterisk -rx "module reload app_queue.so"