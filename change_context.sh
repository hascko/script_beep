#!/bin/bash
#------------------------------------------------------------------------------------------------------------------------------------------
#BEEP
#CHANGER DE CONTEXTE
#AUTEUR MOUGNIN SERGE
#Date 11/05/2016
#------------------------------------------------------------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------------------------------------------------------------
#Arguments
#
#$1 : le nom du client
#$2 : Option de transfert
#$3 : Nouveau Groupe
#$4 : Nouveau mot de passe
#$5 : Le protocole
#------------------------------------------------------------------------------------------------------------------------------------------

if test -z $#;
        then
                /bin/echo "Erreur ! Entrer en argument 1, le nom du client, en 2 l'option de transfert (0,1), en 3 le nouveau groupe et en argument 4 le nouveau groupe"
        else
                if [ $5 = 'SIP' ]
                        then
                                if ( find /var/user/$1.conf 2>/dev/null )
                                	then
                                		#Creation d'un point de sauvegarde
						                cp /var/user/$1.conf /var/user/.old/$1.conf

						                #Suppression de la ligne de mot de passe
						                sed '/secret/d' /var/user/$1.conf > /var/tmp/temp
						                mv /var/tmp/temp /var/user/$1.conf

						                #Réécriture de la ligne
						                sed "4i secret=$4" /var/user/$1.conf > /var/tmp/temp
						                mv /var/tmp/temp /var/user/$1.conf

						                #Suppression de la ligne du groupe
						                sed '/context/d' /var/user/$1.conf > /var/tmp/temp
						                mv /var/tmp/temp /var/user/$1.conf

						                #Réécriture de la ligne
						                sed "4i context=$3" /var/user/$1.conf > /var/tmp/temp
						                mv /var/tmp/temp /var/user/$1.conf
						            else
						            	/bin/echo "Entrez un utilisateur existant"

						    elif [ $5 = 'DAHDI' ]
                                then
                                	if ( find /var/user/dahdi_$1.conf )
                                        then
                                        	#Creation d'un point de sauvegarde
						                cp /var/user/$1.conf /var/user/.old/$1.conf

						                #Suppression de la ligne de mot de passe
						                sed '/secret/d' /var/user/$1.conf > /var/tmp/temp
						                mv /var/tmp/temp /var/user/$1.conf

						                #Réécriture de la ligne
						                sed "4i secret=$4" /var/user/$1.conf > /var/tmp/temp
						                mv /var/tmp/temp /var/user/$1.conf

						                #Suppression de la ligne du groupe
						                sed '/context/d' /var/user/$1.conf > /var/tmp/temp
						                mv /var/tmp/temp /var/user/$1.conf

						                #Réécriture de la ligne
						                sed "4i context=$3" /var/user/$1.conf > /var/tmp/temp
						                mv /var/tmp/temp /var/user/$1.conf
						            else
						            	/bin/echo "Entrez un utilisateur existant"
fi

#Redemarrage des services asterisk
asterisk -rx "dialplan reload"