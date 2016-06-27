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
#$1 : login
#$2 : Ancien Groupe
#$3 : Nouveau Groupe
#$4 : Numero SIP
#$5 : Le protocole
#$6 : Nom
#$7 : Mail
#------------------------------------------------------------------------------------------------------------------------------------------
arg=$#

if [ $arg != 7 ]
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
						#sed '/secret/d' /var/user/$1.conf > /var/tmp/temp
						#mv /var/tmp/temp /var/user/$1.conf

						#Réécriture de la ligne
						#sed "4i secret=$4" /var/user/$1.conf > /var/tmp/temp
						#mv /var/tmp/temp /var/user/$1.conf
						
						#Suppression dans dialplan.conf
						sed -i -e "/(voicemail,$1)    ;----$1----/d" /var/dialplan/$2.conf
						
						#Suppression dans voicemail.conf
						sed -i -e "/;----$1----/d" /etc/asterisk/voicemail.conf
						
						#Suppression de la ligne du groupe
						sed '/context/d' /var/user/$1.conf > /var/tmp/temp
						mv /var/tmp/temp /var/user/$1.conf

						#Réécriture de la ligne
						sed "4i context=$3" /var/user/$1.conf > /var/tmp/temp
						mv /var/tmp/temp /var/user/$1.conf
						
						#Réécriture dans dialplan.conf
						if ( find /var/dialplan/$3.conf 2>/dev/null )
                            then
								#Ajout du dialplan
								/bin/echo "Plan d'appels existants"
								/bin/echo "exten => $4,1,Macro(voicemail,$1)    ;----$1----" >> /var/dialplan/$3.conf

								#Ajout du mail
								/bin/echo "[$3]    ;----$1----" >> /etc/asterisk/voicemail.conf
								/bin/echo "$4 => $2,$1,$7    ;----$1----" >> /etc/asterisk/voicemail.conf
						else
								#Creation du dialplan
								/bin/echo "[$3]    ;----$1----" >> /var/dialplan/$3.conf
								/bin/echo "#include \"/var/dialplan/macro.conf\"    ;----$1----" >> /var/dialplan/$3.conf
								/bin/echo "include => macro-voicemail    ;----$1----" >> /var/dialplan/$3.conf
								/bin/echo "     ;----$1----" >> /var/dialplan/$3.conf
								/bin/echo "exten => $4,1,Macro(voicemail,$1)    ;----$1----" >> /var/dialplan/$3.conf
								/bin/echo "#include \"/var/dialplan/$3.conf\"    ;----$1----" >> /etc/asterisk/extensions.conf

								#Ajout du mail
								/bin/echo "[$3]    ;----$1----" >> /etc/asterisk/voicemail.conf
								/bin/echo "$4 => $2,$1,$7    ;----$1----" >> /etc/asterisk/voicemail.conf
					fi
				else
						/bin/echo "Entrez un utilisateur existant"
				fi
		
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
		fi
fi

#Suppression dialplan ancien groupe
#fichier='/var/dialplan/$2.conf'
#if  [ -e $fichier ]
#	then
		rm /var/dialplan/$2.conf
#fi


#Redemarrage des services asterisk
asterisk -rx "dialplan reload"
asterisk -rx "sip reload"