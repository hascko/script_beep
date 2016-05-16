#!/bin/bash
#---------------------------------------------------------------------
#BEEP
#AJOUT D'UN UTILISATEUR
#AUTEUR MOUGNIN SERGE
#Date 11/05/2016
#---------------------------------------------------------------------

if test -z $#;
        then
                /bin/echo "Erreur ! Entrer en argument 1 et 2 l'heure et la minute de début, en argument 3 et 4 l'heure et la minute de fin et en 5 et 6 la plage de jours en anglais"
        else
                #Suppression de la ligne de configuration
                sed '/GotoIfTime/d' /var/dialplan/standard.conf > /var/tmp/temp
                mv /var/tmp/temp /var/dialplan/standard.conf

                #Réécriture de la ligne avec nos parametres
                sed "5i exten => 123,1,GotoIfTime($1:$2-$3:$4,$5-$6,*,*?standard1,${EXTEN},1)" /var/dialplan/standard.conf > /var/tmp/temp
                mv /var/tmp/temp /var/dialplan/standard.conf
fi

#Redemarrage de Asterisk
/usr/sbin/service asterisk reload