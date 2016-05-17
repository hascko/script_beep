#!/bin/bash
#---------------------------------------------------------------------
#BEEP
#Suppression d'utilisateur
#AUTEUR MOUGNIN SERGE
#Date 11/05/2016
#---------------------------------------------------------------------

if test -z $#;
        then
            /bin/echo "Erreur ! Entrer en argument 1 le nom de l'utilisateur et en argument 2 le contexte"
        else

        	if ( find /var/dialplan/$2.conf )
                
                then
	                #Recherche de l'utilisateur
	                sed '$1/d' /var/dialplan/$2.conf > /var/tmp/temp
	                mv /var/tmp/temp /var/dialplan/$2.conf

	                #Suppression de l'utilisateur
	                rm /var/user/$1.conf

                    #Suppression dqns SIP
                    sed '$1/d' /etc/asterisk/sip.conf > /var/tmp/temp
                    mv /var/tmp/temp /etc/asterisk/sip.conf

                    #Suppression dqns Voice;ail
                    sed '$1/d' /etc/asterisk/voicemail.conf > /var/tmp/temp
                    mv /var/tmp/temp /etc/asterisk/voicemail.conf
	            else
                    #Affichage du message
                    /bin/echo "Entrer un contexte existant"
fi

#Redemarrage de Asterisk
/usr/sbin/service asterisk reload