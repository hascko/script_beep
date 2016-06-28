#!/bin/bash
#------------------------------------------------------------------------------------------------------------------------------------------
#BEEP
#MODIFICATION HORIARES STANDARD
#AUTEUR MOUGNIN SERGE
#Date 11/05/2016
#------------------------------------------------------------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------------------------------------------------------------
#Arguments
#
#$1 : L'heure de début
#$2 : Les minutes de l'heure de début
#$3 : L'heure de fin
#$4 : Les minutes de l'heure de fin
#$5 : Le jour de début (mon, tue, wed, thu, fri, sat, sun)
#$6 : Le jour de fin (mon, tue, wed, thu, fri, sat, sun)
#$7 : Le nouvel utilisateur
#------------------------------------------------------------------------------------------------------------------------------------------

if test -z $#;
        then
                /bin/echo "Erreur ! Entrer en argument 1 et 2 l'heure et la minute de début, en argument 3 et 4 l'heure et la minute de fin et en 5 et 6 la plage de jours en anglais"
        else
                #Suppression de la ligne de configuration
                sed '/GotoIfTime/d' /var/dialplan/standard.conf > /var/tmp/temp
                mv /var/tmp/temp /var/dialplan/standard.conf

                #Réécriture de la ligne avec nos parametres
                sed "5i exten => 1010,1,GotoIfTime($1:$2-$3:$4,$5-$6,*,*?opened,\${EXTEN},1)" /var/dialplan/standard.conf > /var/tmp/temp
                mv /var/tmp/temp /var/dialplan/standard.conf
				
				sed "8i exten => 1011,1,GotoIfTime($1:$2-$3:$4,$5-$6,*,*?opened,\${EXTEN},1)" /var/dialplan/standard.conf > /var/tmp/temp
                mv /var/tmp/temp /var/dialplan/standard.conf
fi

#Redemarrage des services asterisk
asterisk -rx "dialplan reload"
asterisk -rx "sip reload"