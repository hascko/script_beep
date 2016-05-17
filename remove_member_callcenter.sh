#!/bin/bash

chaine=$1
nom_call=$2

asterisk -rx "queue remove member $chaine from $nom_call"

asterisk -rx "module reload app_queue.so"
asterisk -rx "dialplan reload"