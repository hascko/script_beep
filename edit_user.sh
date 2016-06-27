#!/bin/bash

if test -z $#;
        then
                /bin/echo "Erreur ! Entrer en argument 1 et 2 l'heure et la minute de début, en argument 3 et 4 l'heure et la minute de fin et en 5 et 6 la plage de jours en anglais"
        else
				test=`grep -w ";----$1----" /var/dialplan/$2.conf`
				sed -i -e "/;----$1----/d" /var/dialplan/$2.conf
				echo $test >> /var/dialplan/default.conf

fi

#Redemarrage des services asterisk
asterisk -rx "dialplan reload"