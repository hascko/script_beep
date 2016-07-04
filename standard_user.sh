#!/bin/bash
#------------------------------------------------------------------------------------------------------------------------------------------
#BEEP
#MODIFICATION UTILISATEUR STANDARD
#AUTEUR MOUGNIN SERGE
#Date 11/05/2016
#------------------------------------------------------------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------------------------------------------------------------
#Arguments
#
#$1 : Nouvel Utilisateur
#------------------------------------------------------------------------------------------------------------------------------------------

if test -z $#;
        then
                /bin/echo "Erreur ! Entrer en argument 1 et 2 l'heure et la minute de début, en argument 3 et 4 l'heure et la minute de fin et en 5 et 6 la plage de jours en anglais"
        else
                #Suppression de la ligne de configuration
                sed '/UTILISATEUR/d' /var/dialplan/standard.conf > /var/tmp/temp
                mv /var/tmp/temp /var/dialplan/standard.conf

                #Réécriture de la ligne avec nos parametres
                sed "16i exten => 1011,1,Dial(SIP\/$1,15,tT)   ;----UTILISATEUR----;" /var/dialplan/standard.conf > /var/tmp/temp
                mv /var/tmp/temp /var/dialplan/standard.conf
				
				sed "17i exten => s,1,Dial(SIP\/$1,15,tT)      ;----UTILISATEUR----;" /var/dialplan/standard.conf > /var/tmp/temp
                mv /var/tmp/temp /var/dialplan/standard.conf
fi

#Redemarrage des services asterisk
asterisk -rx "dialplan reload"
asterisk -rx "sip reload"