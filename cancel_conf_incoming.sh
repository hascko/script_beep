#!/bin/bash

receiver=$1
num1=$2
num2=$3
num3=$4

sed '/\;'$receiver\_$num1\_$num2\_$num3' \+/d' /var/dialplan/ippi.conf > /var/tmp/temp
mv /var/tmp/temp /var/dialplan/ippi.conf

sed -i "/\;$receiver\_$num1\_$num2\_$num3/,/\;fin $receiver\_$num1\_$num2\_$num3/d" /var/dialplan/ippi.conf

vision=`grep  "GotoIf" /var/dialplan/ippi.conf`

echo $vision > file.tmp

set -a tableau
part="depart"
i=0
while [ ! -z "$part" ]
do
        part=`grep "exten" file.tmp | cut -d"+" -f$((i + 1))`
        if [ ! -z "$part" ];then
                echo $i

                echo "$part+" > file2.tmp

                set -a tableau2
                part2="depart"
                y=0
                while [ ! -z "$part2" ]
                do
                part2=`grep "exten" file2.tmp | cut -d"," -f$((y + 1))`
                if [ ! -z "$part2" ];then
                        tableau2[$y]=$part2
                        let y++
                fi
                done

                tableau2[1]=$((i + 1))

                motfinal=""
                h=0
                taille2=${#tableau2[@]}
                while [ "$taille2" -gt "$h" ]
                do
                motfinal=$motfinal${tableau2[$h]}
                let h++
                if [ "$h" -lt "$taille2" ];then
                motfinal=$motfinal,
                fi
                done

                tableau[$i]="$motfinal"
                let i++
        fi
done

sed '/GotoIf/d' /var/dialplan/ippi.conf > /var/tmp/temp
mv /var/tmp/temp /var/dialplan/ippi.conf

taille=${#tableau[@]}
i=0
p1=`grep -w -n ";fin les conditions" /var/dialplan/ippi.conf | cut -d":" -f1`

while [ "$taille" -gt "$i" ]
do
sed ""$p1"i ${tableau[$i]}"  /var/dialplan/ippi.conf > fichier.tmp && mv -f fichier.tmp /var/dialplan/ippi.conf; rm -f fichier.tmp
let i++
done

asterisk -rx "reload"