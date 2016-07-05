#!/bin/bash

if test -z $#;
        then
                /bin/echo "Erreur ! Entrer en argument 1 et 2 l'heure et la minute de début, en argument 3 et 4 l'heure et la minute de fin et en 5 et 6 la plage de jours en anglais"
        else
				test=`grep -w ";----$1----" /var/dialplan/$2.conf`
				sed -i -e "/;----$1----/d" /var/dialplan/$2.conf
				echo $test >> /var/dialplan/$3.conf
				
				#Suppression de la ligne du groupe
			
				
				sed '/secret/d' /var/user/$1.conf > /var/tmp/temp
				mv /var/tmp/temp /var/user/$1.conf
					
				sed "3i secret=$4" /var/user/$1.conf > /var/tmp/temp
				mv /var/tmp/temp /var/user/$1.conf
				#Réécriture de la ligne
				sed '/context/d' /var/user/$1.conf > /var/tmp/temp
				mv /var/tmp/temp /var/user/$1.conf	
				
				sed "4i context=$3" /var/user/$1.conf > /var/tmp/temp
				mv /var/tmp/temp /var/user/$1.conf				
				


fi

#Redemarrage des services asterisk
asterisk -rx "dialplan reload"
asterisk -rx "sip reload"