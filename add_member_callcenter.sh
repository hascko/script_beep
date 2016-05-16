#!/bin/bash

chaine=$1
nom_call=$2

asterisk -rx "queue add member $chaine to $nom_call"

asterisk -rx "module reload app_queue.so"