#!/bin/bash
#------------------------------------------------------------------------------------------------------------------------------------------
#BEEP
#Suppression d'utilisateur
#AUTEUR MOUGNIN SERGE
#Date 11/05/2016
#------------------------------------------------------------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------------------------------------------------------------
#Arguments
#
#$1 : Le pseudo de l'utilisateur
#$2 : Le contexte de l'utilisateur
#------------------------------------------------------------------------------------------------------------------------------------------

if test -z $#;
        then
            /bin/echo "Erreur ! Entrer en argument 1 le nom de l'utilisateur et en argument 2 le contexte"
        else

        	if ( find /var/dialplan/$2.conf )
                
                then
	                #Recherche de l'utilisateur
	                sed /$1/d /var/dialplan/$2.conf > /var/tmp/temp
	                mv /var/tmp/temp /var/dialplan/$2.conf

                    chan=`test -s /var/dialplan/$2.conf`
                    
                    if [ -z "$chan" ];
                    
                        then 
                               rm /var/dialplan/$2.conf
                        else
                              /bin/echo "Dialplan supprimé"
                        fi

                    #Affichage
                    /bin/echo "Dialplan supprimé"

	                #Suppression de l'utilisateur
	                rm /var/user/$1.conf

                    #Suppression dqns SIP
                    sed /$1/d /etc/asterisk/sip.conf > /var/tmp/temp
                    mv /var/tmp/temp /etc/asterisk/sip.conf

                    #Suppression dqns extensions
                    sed /$2/d /etc/asterisk/extensions.conf > /var/tmp/temp
                    mv /var/tmp/temp /etc/asterisk/extensions.conf

                    #Suppression dqns Chan_dahdi
                    sed /$1/d /etc/asterisk/chan_dahdi.conf > /var/tmp/temp
                    mv /var/tmp/temp /etc/asterisk/chan_dahdi.conf

                    #Suppression dqns Voicemail
                    sed /$1/d /etc/asterisk/voicemail.conf > /var/tmp/temp
                    mv /var/tmp/temp /etc/asterisk/voicemail.conf
	            else
                    #Affichage du message
                    /bin/echo "Entrer un contexte existant"
            fi
fi

#Redemarrage des services asterisk
asterisk -rx "dialplan reload"
asterisk -rx "sip reload"