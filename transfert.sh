#!/bin/bash
#---------------------------------------------------------------------
#BEEP
#OPTION DE TRANSFERT
#AUTEUR MOUGNIN SERGE
#Date 11/05/2016
#---------------------------------------------------------------------

if test -z $#;
        then
                /bin/echo "Erreur ! Entrer en argument 1 et 2 le nom et l'option 0 ou 1"
        else
                #Recherche de l'utilisateur
                sed '/GotoIfTime/d' /var/dialplan/standard.conf > /var/tmp/temp
                mv /var/tmp/temp /var/dialplan/standard.conf

                #Réécriture de la ligne avec nos parametres
                sed "5i exten => 123,1,GotoIfTime($1:$2-$3:$4,$5-$6,*,*?standard1,${EXTEN},1)" /var/dialplan/standard.conf > /var/tmp/temp
                mv /var/tmp/temp /var/dialplan/standard.conf

				exten => s,n,Set(temp=${DB(CFBS/${ARG1})})
				exten => s,n,GotoIf(${temp}?cfbs:nocfbs)
				exten => s,n(cfbs),Dial(Local/${temp}@default/n) ; Forward on busy or unavailable 
				exten => s,n(nocfbs),Busy
fi

#Redemarrage de Asterisk
/usr/sbin/service asterisk reload