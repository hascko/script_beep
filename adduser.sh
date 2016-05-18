#!/bin/bash
#---------------------------------------------------------------------
#BEEP
#AJOUT D'UN UTILISATEUR
#AUTEUR MOUGNIN SERGE
#Date 11/05/2016
#---------------------------------------------------------------------

---------------------------------------------------------------------
#Arguments
#
#$1 : Le pseudo de l'utilisateur
#$2 : Le mot de passe de l'utilisateur
#$3 : L'adresse mail de l'utilisateur
#$4 : L'extension (numéro) de l'utilisateur
#$5 : Le protocole de l'utilisateur SIP ou DAHDI
#$6 : Le port Dahdi
#$7 : L'option de transfert
#$8 : Le numéro de téléphone
#$9 : Le contexte auquel on veut l'utilisateur
#---------------------------------------------------------------------

if test -z "$1";
        then
                /bin/echo "Erreur ! Entrer les bons arguments"
        else

                if [ $5 = 'SIP' ]
                        then
                                if ( find /var/dialplan/$9.conf 2>/dev/null )
                                        then
                                                #Ajout du dialplan
                                                /bin/echo "Plan d'appels existants"
                                                /bin/echo "exten => $4,1,Macro(travail,$1)" >> /var/dialplan/$9.conf

                                                #Ajout du mail
                                                /bin/echo "[$9]" >> /etc/asterisk/voicemail.conf
                                                /bin/echo "$4 => $2,$1,$3" >> /etc/asterisk/voicemail.conf
                                        else
                                                #Creation du dialplan
                                                /bin/echo "[$9]" >> /var/dialplan/$9.conf
                                                /bin/echo "#include \"/var/dialplan/macro.conf\"" >> /var/dialplan/$9.conf
                                                /bin/echo "include => macro-travail" >> /var/dialplan/$9.conf
                                                /bin/echo " " >> /var/dialplan/$9.conf
                                                /bin/echo "exten => $4,1,Macro(travail,$1)" >> /var/dialplan/$9.conf
                                                /bin/echo "#include \"/var/dialplan/$9.conf\"" >> /etc/asterisk/extensions.conf

                                                #Ajout du mail
                                                /bin/echo "[$9]" >> /etc/asterisk/voicemail.conf
                                                /bin/echo "$4 => $2,$1,$3" >> /etc/asterisk/voicemail.conf
                                fi

                                if ( find /var/user/$1.conf 2>/dev/null )
                                        then
                                                #Message pour indiquer le groupe
                                                /bin/echo "Utilisateur existant"
                                        else
                                                #Creation de l'utilisateur dans /var/user
                                                /bin/echo "[$1]" >> /var/user/$1.conf
                                                /bin/echo "type=friend" >> /var/user/$1.conf
                                                /bin/echo "secret=$2" >> /var/user/$1.conf
                                                /bin/echo "context=$9" >> /var/user/$1.conf
                                                /bin/echo "username=$1" >> /var/user/$1.conf
                                                /bin/echo "host=dynamic" >> /var/user/$1.conf
                                                /bin/echo "#include \"/var/user/$1.conf\"" >> /etc/asterisk/sip.conf
                                fi
                        
                        elif [ $5 = 'DAHDI' ]
                                then
                                if ( find /var/dialplan/dahdi_$9.conf 2>/dev/null )
                                        then
                                                #Ajout du dialplan
                                                /bin/echo "Plan d'appels existants"
                                                /bin/echo "exten => $4,1,Dial(dahdi/2/30)" >> /var/dialplan/dahdi_$9.conf

                                                #Ajout du mail
                                                /bin/echo "[$9]" >> /etc/asterisk/voicemail.conf
                                                /bin/echo "$4 => $2,$1,$3" >> /etc/asterisk/voicemail.conf
                                        else
                                                #Creation du dialplan
                                                /bin/echo "[$9]" >> /var/dialplan/dahdi_$9.conf
                                                /bin/echo " " >> /var/dialplan/dahdi_$9.conf
                                                /bin/echo "exten => $4,1,Dial(dahdi/2/30)" >> /var/dialplan/dahdi_$9.conf
                                                /bin/echo "#include \"/var/dialplan/dahdi_$9.conf\"" >> /etc/asterisk/extensions.conf

                                                #Ajout du mail
                                                /bin/echo "[$9]" >> /etc/asterisk/voicemail.conf
                                                /bin/echo "$4 => $2,$1,$3" >> /etc/asterisk/voicemail.conf
                                fi

                                chan=`grep -h "channel=$6" "/var/user/dahdi_*.conf"`

                                if ( find /var/user/dahdi_$1.conf )
                                        then
                                                #Message pour indiquer le groupe
                                                /bin/echo "Utilisateur existant"
                                        else
                                                #Creation de l'utilisateur dans /var/user
                                                /bin/echo "signaling=fxo_ks" >> /var/user/dahdi_$1.conf
                                                /bin/echo "callerid=combinet <$4>" >> /var/user/dahdi_$1.conf
                                                /bin/echo "echocancel=yes" >> /var/user/dahdi_$1.conf

                                                if [ -z "$chan" ];

                                                        then 
                                                                /bin/echo "group=$6" >> /var/user/dahdi_$1.conf
                                                                /bin/echo "channel=$6" >> /var/user/dahdi_$1.conf
                                                else
                                                                     /bin/echo "Ce Port est occupé";
                                                fi
												/bin/echo "#include \"/var/dialplan/dahdi_$1.conf\"" >> /etc/asterisk/chan_dahdi.conf
                                fi

                        else
                                echo "Entrez un protocole valide : SIP ou DHADI"
                fi
fi

#Redemarrage des services asterisk
asterisk -rx "dialplan reload"
asterisk -rx "sip reload"
