#!/bin/bash
#---------------------------------------------------------------------
#BEEP
#AJOUT D'UN UTILISATEUR
#AUTEUR MOUGNIN SERGE
#Date 11/05/2016
#---------------------------------------------------------------------

if test -z "$1";
        then
                /bin/echo "Erreur ! Entrer les bons arguments"
        else

                if [ $5 = 'SIP' ]
                        then
                                if ( find /var/dialplan/$8.conf )
                                        then
                                                #Ajout du dialplan
                                                /bin/echo "Plan d'appels existants"
                                                /bin/echo "exten => $4,1,Macro(travail,$1)" >> /var/dialplan/$8.conf

                                                #Ajout du mail
                                                /bin/echo "[$8]" >> /etc/asterisk/voicemail.conf
                                                /bin/echo "$4 => $2,$1,$3" >> /etc/asterisk/voicemail.conf
                                        else
                                                #Creation du dialplan
                                                /bin/echo "[$8]" >> /var/dialplan/$8.conf
                                                /bin/echo "#include \"/var/dialplan/macro.conf\"" >> /var/dialplan/$8.conf
                                                /bin/echo "include => macro-travail" >> /var/dialplan/$8.conf
                                                /bin/echo " " >> /var/dialplan/$8.conf
                                                /bin/echo "exten => $4,1,Macro(travail,$1)" >> /var/dialplan/$8.conf
                                                /bin/echo "#include \"/var/dialplan/$8.conf\"" >> /etc/asterisk/extensions.conf

                                                #Ajout du mail
                                                /bin/echo "[$8]" >> /etc/asterisk/voicemail.conf
                                                /bin/echo "$4 => $2,$1,$3" >> /etc/asterisk/voicemail.conf
                                fi

                                if ( find /var/user/$1.conf )
                                        then
                                                #Message pour indiquer le groupe
                                                /bin/echo "Utilisateur existant"
                                        else
                                                #Creation de l'utilisateur dans /var/user
                                                /bin/echo "[$1]" >> /var/user/$1.conf
                                                /bin/echo "type=friend" >> /var/user/$1.conf
                                                /bin/echo "secret=$2" >> /var/user/$1.conf
                                                /bin/echo "context=$8" >> /var/user/$1.conf
                                                /bin/echo "username=$1" >> /var/user/$1.conf
                                                /bin/echo "host=dynamic" >> /var/user/$1.conf
                                                /bin/echo "#include \"/var/user/$1.conf\"" >> /etc/asterisk/sip.conf
                                fi
                        
                        elif [ $5 = 'DAHDI' ]
                                then
                                if ( find /var/dialplan/dahdi_$8.conf )
                                        then
                                                #Ajout du dialplan
                                                /bin/echo "Plan d'appels existants"
                                                /bin/echo "exten => $4,1,Dial(dahdi/2/30)" >> /var/dialplan/dahdi_$8.conf

                                                #Ajout du mail
                                                /bin/echo "[$8]" >> /etc/asterisk/voicemail.conf
                                                /bin/echo "$4 => $2,$1,$3" >> /etc/asterisk/voicemail.conf
                                        else
                                                #Creation du dialplan
                                                /bin/echo "[$8]" >> /var/dialplan/dahdi_$8.conf
                                                /bin/echo " " >> /var/dialplan/dahdi_$8.conf
                                                /bin/echo "exten => $4,1,Dial(dahdi,2,30)" >> /var/dialplan/dahdi_$8.conf
                                                /bin/echo "#include \"/var/dialplan/dahdi_$8.conf\"" >> /etc/asterisk/extensions.conf

                                                #Ajout du mail
                                                /bin/echo "[$8]" >> /etc/asterisk/voicemail.conf
                                                /bin/echo "$4 => $2,$1,$3" >> /etc/asterisk/voicemail.conf
                                fi

                                chan1=`grep -h "channel1" "/var/user/dahdi_*.conf"`
                                chan2=`grep -h "channel2" "/var/user/dahdi_*.conf"`
                                chan3=`grep -h "channel3" "/var/user/dahdi_*.conf"`

                                if ( find /var/user/dahdi_$1.conf )
                                        then
                                                #Message pour indiquer le groupe
                                                /bin/echo "Utilisateur existant"
                                        else
                                                #Creation de l'utilisateur dans /var/user
                                                /bin/echo "signaling=fxo_ks" >> /var/user/dahdi_$1.conf
                                                /bin/echo "callerid=combinet <$4>" >> /var/user/dahdi_$1.conf
                                                /bin/echo "echocancel=yes" >> /var/user/dahdi_$1.conf

                                                if [ -z "$chan3" ];

                                                        then 
                                                                /bin/echo "group=3" >> /var/user/dahdi_$1.conf
                                                                /bin/echo "channel=3" >> /var/user/dahdi_$1.conf

                                                elif [ -z "$chan2" ];

                                                        then
                                                                /bin/echo "group=2" >> /var/user/dahdi_$1.conf
                                                                /bin/echo "channel=2" >> /var/user/dahdi_$1.conf

                                                elif [ -z "$chan1" ];

                                                        then
                                                                /bin/echo "group=1" >> /var/user/dahdi_$1.conf
                                                                /bin/echo "channel=1" >> /var/user/dahdi_$1.conf

                                                else
                                                                     /bin/echo "Plus de disponibilité pour Dahdi";
                                                fi

                                                #/bin/echo "#include \"/var/dialplan/dahdi_$1.conf\"" >> /etc/asterisk/chan_dahdi.conf
                                fi

                        else
                                echo "Entrez un protocole valide : SIP ou DHADI"
                fi
fi

#Redemarrage Asterisk
/usr/sbin/service asterisk reload
