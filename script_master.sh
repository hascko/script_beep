#!/bin/bash

reponse="oui"
while [ $reponse == "oui" ]
do
echo "BIENVENUE SUR L'INTERFACE DU SCRIPT MASTER DE BEEP"
echo "1-  AJOUTER UN NOUVEAU COMPTE UTILISATEUR"
echo "2-  SUPPRIMER UN COMPTE UTILISATEUR"
echo "3-  AJOUTER UN NOUVEAU CALLCENTER"
echo "4-  SUPPRIMER UN CALLCENTER"
echo "5-  AJOUTER UN MEMBRE A UN CALLCENTER"
echo "6-  RETIRER UN MEMBRE D'UN CALLCENTER"
echo "7-  AJOUTER UN NOUVEAU TRUNK"
echo "8-  SUPPRIMER UN TRUNK"
echo "9-  DROIT D'APPEL BIDIRECTIONNEL"
echo "10- ANNULER UN DROIT D'APPEL BIDIRECTIONNEL"
echo "11- DROIT D'APPEL UNIDIRECTIONNEL"
echo "12- ANNULER UN DROIT D'APPEL UNIDIRECTIONNEL"
echo "13- CREER UNE CONFERENCE"
echo "14- SUPPRIMER UNE CONFERENCE"
echo "15- MODIFIER L'HORAIRE DU STANDARD"
echo "16- MODIFIER L'OPTION DE TRANSFERT D'APPEL"
echo "17- MODIFIER LES OPTIONS D'UNE CONFERENCE"
echo " "
echo "CHOISISSEZ LA FONCTION QUE VOUS VOULEZ UTILISER"
read choix
case $choix in
        "1")
                echo "ENTREZ LE NOM DE L'UTILISATEUR SVP"
                read user
                echo "ENTREZ LE MOT DE PASSE DE L'UTILISATEUR SVP"
                read mdp
                echo "ENTREZ LE MAIL DE L'UTILISATEUR SVP"
                read mail
                echo "ENTREZ NUMERO OU EXTENSION DE L'UTILISATEUR SVP"
                read numero
                echo "ENTREZ LE PROTOCOLE DE L'UTILISATEUR (SIP OU DAHDI)"
                read protocol
                echo "ENTREZ LE PORT DAHDI"
                read port
                echo "ENTREZ L'OPTION DE TRANSFERT"
                read option
                echo "ENTREZ LE NUMERO DE TELEPHONE RATTACHE A CE COMPTE"
                read number
                echo "ENTREZ LE CONTEXT DANS LEQUEL SERA L'UTILISATEUR SVP"
                read context
                /var/script_beep/adduser.sh $user $mdp $mail $numero $protocol $port $option $number $context
                echo "L'UTILISATEUR A BIEN ETE ENREGISTRE"
        ;;
        "2")
                echo "ENTREZ LE NOM DE L'UTILISATEUR"
                read user
                echo "ENTREZ LE CONTEXT DE L'UTILISATEUR"
                read context
                /var/script_beep/deleteuser.sh $user $context
                echo "L'UTILISATEUR A BIEN ETE SUPPRIME"
        ;;
        "3")
                echo "ENTREZ LE NOM DU CALLCENTER SVP"
                read nom_call
                echo "ENTREZ LA STRATEGY DU CALLCENTER SVP"
                read strategy
                echo "ENTREZ LE NUMERO DU CALLCENTER"
                read numero_call
                /var/script_beep/add_callcenter.sh $nom_call $strategy $numero_call
                echo "LE NOUVEAU CALLCENTER A BIEN ETE ENREGISTRE"
        ;;
        "4")
                echo "ENTREZ LE NOM DU CALLCENTER SVP"
                read nom_call
                /var/script_beep/remove_callcenter.sh $nom_call
                echo "LE CALLCENTER A BIEN ETE SUPPRIME"
        ;;
        "5")
                echo "ENTREZ LA CHAINE DU MEMBRE SVP"
                read chaine
                echo "ENTREZ LE NOM DU CALLCENTER"
                read nom_call
                /var/script_beep/add_member_callcenter.sh $chaine $nom_call
                echo "LE MEMBRE A BIEN ETE AJOUTE AU CALLCENTER"
        ;;
        "6")
                echo "ENTREZ LA CHAINE DU MEMBRE SVP"
                read chaine
                echo "ENTREZ LE NOM DU CALLCENTER"
                read nom_call
                /var/script_beep/remove_member_callcenter.sh $chaine $nom_call
                echo "LE MEMBRE A BIEN ETE RETIRE DU CALLCENTER"
        ;;
        "7")
                echo "ENTREZ LE COMPTE DU TRUNK SVP"
                read compte
                echo "ENTREZ LE MOT DE PASSE DU COMPTE SVP"
                read passwd
                echo "ENTREZ LE HOST SVP"
                read host
                echo "ENTREZ LE NUMERO GEOGRAPHIQUE SVP, SI INEXISTANT METTEZ ZERO"
                read num_geo
                echo "ENTREZ LE NUMERO SIP SVP, SI INEXISTANT METTEZ ZERO"
                read num_sip
                echo "ENTREZ LE INUM SVP, SI INEXISTANT METTEZ ZERO"
                read num_inum
                echo "ENTREZ LA BRANCHE RATTACHEE A CE TRUNK"
                read branch
                /var/script_beep/add_trunk.sh $compte $passwd $host $num_geo $num_sip $num_inum $branch
                echo "LE NOUVEAU A BIEN ETE AJOUTE"
        ;;
        "8")
                echo "ENTREZ LA BRANCHE RATTACHEE AU TRUNK SVP"
                read branch
                /var/script_beep/remove_trunk.sh $branch
                echo "LE TRUNK VIENT D'ETRE SUPPRIME"
        ;;
        "9")
                echo "ENTREZ LE NOM DU CONTEXTE"
                read context1
                echo "ENTREZ LE NOM DU SECOND CONTEXTE"
                read context2
                /var/script_beep/droit_appel_bidirectionnel.sh $context1 $context2
                echo "LES CONTEXTES PEUVENT SE JOINDRE MAINTENANT"
        ;;
        "10")
                echo "ENTREZ LE NOM DU CONTEXTE"
                read context1
                echo "ENTREZ LE NOM DU SECOND CONTEXTE"
                read context2
                /var/script_beep/delete_droit_bidirectionnel.sh $context1 $context2
                echo "LES CONTEXTES NE PEUVENT PLUS SE JOINDRE MAINTENANT"
        ;;
        "11")
                echo "ENTREZ LE NOM DU CONTEXTE"
                read context1
                echo "ENTREZ LE NOM DU CONTEXTE QUI AURA LE DROIT"
                read context2
                /var/script_beep/droit_appel_unidirectionnel.sh $context2 $context1
                echo "LE DROIT D'APPEL A BIEN ETE ACCORDE A $context2"
        ;;
        "12")
                echo "ENTREZ LE NOM DU CONTEXTE"
                read context1
                echo "ENTREZ LE NOM DU CONTEXTE QUI PERDRA LE DROIT"
                read context2
                /var/script_beep/delete_droit_unidirectionnel.sh $context2 $context1
                echo "LE DROIT A BIEN ETE RETIRE A $context2"
        ;;
        "13")
                echo "1- CONFERENCE SIMPLE"
                echo "2- CONFERENCE AVEC MOT DCE PASSE"
                read choix2
                case $choix2 in
                        "1")
                                echo "ENTREZ LE NUMERO DE LA CONFERENCE SVP"
                                read numero
                                /var/script_beep/create_conference.pl $numero
                                echo "LA CONFERENCE A BIEN ETE CREEE"
                        ;;
                        "2")
                                echo "ENTREZ LE NUMERO DE LA CONFERENCE SVP"
                                read numero
                                echo "ENTREZ LE MOT DE PASSE QUI EST OBLIGATOIREMENT NUMERIQUE"
                                read mdp
                                /var/script_beep/create_conference.pl $numero $mdp
                                echo "LA CONFERENCE A BIEN ETE CREEE"
                        ;;
                esac
        ;;
        "14")
                echo "1- CONFERENCE SIMPLE"
                echo "2- CONFERENCE AVEC MOT DCE PASSE"
                read choix2
                case $choix2 in
                        "1")
                                echo "ENTREZ LE NUMERO DE LA CONFERENCE SVP"
                                read numero
                                /var/script_beep/delete_conference.pl $numero
                                echo "LA CONFERENCE A BIEN ETE SUPPRIMEE"
                        ;;
                        "2")
                                echo "ENTREZ LE NUMERO DE LA CONFERENCE SVP"
                                read numero
                                echo "ENTREZ LE MOT DE PASSE QUI EST OBLIGATOIREMENT NUMERIQUE"
                                read mdp
                                /var/script_beep/delete_conference.pl $numero $mdp
                                echo "LA CONFERENCE A BIEN ETE SUPPRIMEE"
                        ;;
                esac
        ;;
        "15")
                echo "ENTREZ L'HEURE DE DEBUT SVP"
                read heure_deb
                echo "ENTREZ LA MINUTE DE DEBUT SVP"
                read min_deb
                echo "ENTREZ L'HEURE DE FIN SVP"
                read heure_fin
                echo "ENTREZ LA MINUTE DE FIN SVP"
                read min_fin
                echo "ENTREZ LA DATE DE DEBUT (mon, tue, wed, thu, fri, sat, sun)"
                read date_deb
                echo "ENTREZ LA DATE DE FIN (mon, tue, wed, thu, fri, sat, sun)"
                read date_fin
                /var/script_beep/standard.sh $heure_deb $min_deb $heure_fin $min_fin $date_deb $date_fin
                echo "L'HORAIRE DU STANDARD A BIEN ETE MODIFIE"
        ;;
        "17")
                echo "1 - Pour Activer Musique et TalkOnly Pour conference MDP"
                echo "2 - Pour Activer Que TalkOnly Pour conference MDP"
                echo "3 - Pour Activer Que Musique Pour conference MDP"
                echo "4 - Pour Activer Musique et TalkOnly Pour conference SMDP"
                echo "5 - Pour Activer Que TalkOnly Pour conference MDP"
                echo "6 - Pour Activer Que Musique Pour conference MDP"
                read choix2
                case $choix2 in
                        "1")
                                /var/script_beep/chg_option.pl 1
                        ;;
                        "2")
                                /var/script_beep/chg_option.pl 2
                        ;;
                        "3")
                                /var/script_beep/chg_option.pl 3
                        ;;
                        "4")
                                /var/script_beep/chg_option.pl 4
                        ;;
                        "5")
                                /var/script_beep/chg_option.pl 5
                        ;;
                        "6")
                                /var/script_beep/chg_option.pl 6
                        ;;
                esac
                        echo "L'OPTION A BIEN ETE MODIFIE"
        ;;
esac
echo "VOULEZ-VOUS CONTINUER ?"
read reponse
done