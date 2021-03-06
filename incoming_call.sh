#!/bin/bash

choix=$1
receiver=$2
num1=$3
num2=$4
num3=$5
proposition_svi_1=$6
proposition_svi_2=$7
proposition_svi_3=$8
nom_call=$9

p1=`grep -w -n ";fin les conditions" /var/dialplan/ippi.conf | cut -d":" -f1`
p2=`grep -w -n ";les conditions" /var/dialplan/ippi.conf | cut -d":" -f1`

p=$((p1 - p2))
if [ "$choix" == "1" ];then
        #l'admin a choisi un svi
        echo $p
        if [ "$num3" != "0" ];then
        sed ""$p1"i exten => s,"$p",GotoIf(\$[\${CUT(CUT(SIP_HEADER(TO),@,1),:,2)} = $num3]?"$receiver",s,1) ;"$receiver"_"$num1"_"$num2"_"$num3" +" /var/dialplan/ippi.conf > fichier.tmp && mv -f fichier.tmp /var/dialplan/ippi.conf; rm -f fichier.tmp
        let p++
        fi
        if [ "$num2" != "0" ];then
        sed ""$p1"i exten => s,"$p",GotoIf(\$[\${CUT(CUT(SIP_HEADER(TO),@,1),:,2)} = $num2]?"$receiver",s,1) ;"$receiver"_"$num1"_"$num2"_"$num3" +" /var/dialplan/ippi.conf > fichier.tmp && mv -f fichier.tmp /var/dialplan/ippi.conf; rm -f fichier.tmp
        let p++
        fi
        if [ "$num1" != "0" ];then
        sed ""$p1"i exten => s,"$p",GotoIf(\$[\${CUT(CUT(SIP_HEADER(TO),@,1),:,2)} = $num1]?"$receiver",s,1) ;"$receiver"_"$num1"_"$num2"_"$num3" +" /var/dialplan/ippi.conf > fichier.tmp && mv -f fichier.tmp /var/dialplan/ippi.conf; rm -f fichier.tmp
        let p++
        fi

        if [ "$proposition_svi_1" == "callcenter" ];then
                proposition_svi_1="le centre d'appel"
        elif [ "$proposition_svi_2" == "callcenter" ];then
                proposition_svi_2="le centre d'appel"
        elif [ "$proposition_svi_3" == "callcenter" ];then
                proposition_svi_3="le centre d'appel"
        fi

        echo ";$receiver"_"$num1"_"$num2"_"$num3" >> /var/dialplan/ippi.conf
        echo "[$receiver]" >> /var/dialplan/ippi.conf
        echo "exten => s,1,Answer()" >> /var/dialplan/ippi.conf
        echo "exten => s,2,Set(TIMEOUT(response)=10)" >> /var/dialplan/ippi.conf
        #echo "exten => s,3,agi(googletts.agi,\"Bienvenue chez beep\",fr,any)" >>/var/dialplan/ippi.conf
        echo "exten => s,3,Background(IVR-001)" >>/var/dialplan/ippi.conf
        #echo "exten => s,4,agi(googletts.agi,\"Qui souhaitez vous joindre ?\",fr,any)" >> /var/dialplan/ippi.conf
        echo "exten => s,4,Background(IVR-002)" >> /var/dialplan/ippi.conf
        #echo "exten => s,5,agi(googletts.agi,\"Pour $proposition_svi_1 tapez 1.\",fr,any)" >> /var/dialplan/ippi.conf
        echo "exten => s,5,Background(IVR-003)" >> /var/dialplan/ippi.conf
        #echo "exten => s,6,agi(googletts.agi,\"Pour $proposition_svi_2 tapez 2.\",fr,any)" >> /var/dialplan/ippi.conf
        echo "exten => s,6,Background(IVR-004)" >> /var/dialplan/ippi.conf
        #echo "exten => s,7,agi(googletts.agi,\"Pour $proposition_svi_3 tapez 3.\",fr,any)" >> /var/dialplan/ippi.conf
        echo "exten => s,7,Background(IVR-005)" >> /var/dialplan/ippi.conf
        #echo "exten => s,8,agi(googletts.agi,\"Appuyez sur dièse si vous souhaitez réécouter ce  message\",fr,any)" >> /var/dialplan/ippi.conf
        echo "exten => s,8,Background(IVR-006)" >> /var/dialplan/ippi.conf
        echo "exten => s,9,WaitExten()" >> /var/dialplan/ippi.conf

        if [ "$proposition_svi_1" == "le centre d'appel" ];then
                proposition_svi_1="callcenter"
        elif [ "$proposition_svi_2" == "le centre d'appel" ];then
                proposition_svi_2="callcenter"
        elif [ "$proposition_svi_3" == "le centre d'appel" ];then
                proposition_svi_3="callcenter"
        fi

        if [ "$proposition_svi_1" == "conférence" ];then
                echo "exten => 1,1,agi(googletts.agi,\"Composez le numéro de conférence\",fr,any)" >> /var/dialplan/ippi.conf
                echo "exten => 1,2,Read(ext,\"\",4)" >> /var/dialplan/ippi.conf
                echo "exten => 1,3,Goto(svi,\${ext},1)" >> /var/dialplan/ippi.conf
        elif [ "$proposition_svi_1" == "standard" ];then
                standard=`grep -w "exten => 1011,1,Dial(SIP" /var/dialplan/standard.conf | cut -d"," -f3 | cut -d"/" -f2`
                
                horaire1=`grep -w "exten => 1011,1,GotoIfTime" /var/dialplan/standard.conf | cut -d"," -f3`
                horaire2=`grep -w "exten => 1011,1,GotoIfTime" /var/dialplan/standard.conf | cut -d"," -f4`
                horaire="exten => s,1,$horaire1,$horaire2,*,*?opened,\${EXTEN},1)"
                echo "$horaire" >> /var/dialplan/ippi.conf
                echo "exten => s,n,Goto(closed,${EXTEN},1)" >> /var/dialplan/ippi.conf
                echo "[opened]" >> /var/dialplan/ippi.conf
                echo "exten => s,1,Dial(dahdi/2/30) && Dial(SIP/$1,15,tT)" >> /var/dialplan/ippi.conf
                echo "[closed]" >> /var/dialplan/ippi.conf
                echo "exten => s,1,Answer()" >> /var/dialplan/ippi.conf
                echo "exten => s,n,Playtones(busy)" >> /var/dialplan/ippi.conf
                echo "exten => s,n,Busy(5)" >> /var/dialplan/ippi.conf
                echo "exten => s,n,Hangup" >> /var/dialplan/ippi.conf        
        elif [ "$proposition_svi_1" == "composer" ];then
                echo "exten => 1,1,agi(googletts.agi,\"Composez le numéro de la personne\",fr,any)" >> /var/dialplan/ippi.conf
                echo "exten => 1,2,Read(ext,\"\",4)" >> /var/dialplan/ippi.conf
                echo "exten => 1,3,Goto(svi,\${ext},1)" >> /var/dialplan/ippi.conf
        elif [ "$proposition_svi_1" == "callcenter" ];then
                num_call=`grep -w -n "the $nom_call queue" /var/dialplan/callcenter.conf | cut -d" " -f3 | cut -d"," -f1`
                echo "exten => 1,1,Goto(Queues,$num_call,1)" >> /var/dialplan/ippi.conf
        else
                echo "exten => 1,1,Dial(SIP/$proposition_svi_1)" >> /var/dialplan/ippi.conf
        fi

        if [ "$proposition_svi_2" == "conférence" ];then
                echo "exten => 2,1,Background(IVR-007)" >> /var/dialplan/ippi.conf
                echo "exten => 2,2,Read(ext,\"\",4)" >> /var/dialplan/ippi.conf
                echo "exten => 2,3,Goto(svi,\${ext},1)" >> /var/dialplan/ippi.conf
        elif [ "$proposition_svi_2" == "standard" ];then
                standard=`grep -w "exten => 1011,1,Dial(SIP" /var/dialplan/standard.conf | cut -d"," -f3 | cut -d"/" -f2`
                
                horaire1=`grep -w "exten => 1011,1,GotoIfTime" /var/dialplan/standard.conf | cut -d"," -f3`
                horaire2=`grep -w "exten => 1011,1,GotoIfTime" /var/dialplan/standard.conf | cut -d"," -f4`
                horaire="exten => s,1,$horaire1,$horaire2,*,*?opened,\${EXTEN},1)"
                echo "$horaire" >> /var/dialplan/ippi.conf
                echo "exten => s,n,Goto(closed,${EXTEN},1)" >> /var/dialplan/ippi.conf
                echo "[opened]" >> /var/dialplan/ippi.conf
                echo "exten => s,1,Dial(dahdi/2/30) && Dial(SIP/$1,15,tT)" >> /var/dialplan/ippi.conf
                echo "[closed]" >> /var/dialplan/ippi.conf
                echo "exten => s,1,Answer()" >> /var/dialplan/ippi.conf
                echo "exten => s,n,Playtones(busy)" >> /var/dialplan/ippi.conf
                echo "exten => s,n,Busy(5)" >> /var/dialplan/ippi.conf
                echo "exten => s,n,Hangup" >> /var/dialplan/ippi.conf        
        elif [ "$proposition_svi_2" == "composer" ];then
                echo "exten => 2,1,agi(googletts.agi,\"Composez le numéro de la personne\",fr,any)" >> /var/dialplan/ippi.conf
                echo "exten => 2,2,Read(ext,\"\",4)" >> /var/dialplan/ippi.conf
                echo "exten => 2,3,Goto(svi,\${ext},1)" >> /var/dialplan/ippi.conf
        elif [ "$proposition_svi_2" == "callcenter" ];then
                num_call=`grep -w -n "the $nom_call queue" /var/dialplan/callcenter.conf | cut -d" " -f3 | cut -d"," -f1`
                echo "exten => 1,1,Goto(Queues,$num_call,1)" >> /var/dialplan/ippi.conf
        else
                echo "exten => 2,1,Dial(SIP/$proposition_svi_2)" >> /var/dialplan/ippi.conf
        fi

        if [ "$proposition_svi_3" == "conférence" ];then
                echo "exten => 3,1,agi(googletts.agi,\"Composez le numéro de conférence\",fr,any)" >> /var/dialplan/ippi.conf
                echo "exten => 3,2,Read(ext,\"\",4)" >> /var/dialplan/ippi.conf
                echo "exten => 3,3,Goto(svi,\${ext},1)" >> /var/dialplan/ippi.conf
        elif [ "$proposition_svi_3" == "standard" ];then
                standard=`grep -w "exten => 1011,1,Dial(SIP" /var/dialplan/standard.conf | cut -d"," -f3 | cut -d"/" -f2`
                
                horaire1=`grep -w "exten => 1011,1,GotoIfTime" /var/dialplan/standard.conf | cut -d"," -f3`
                horaire2=`grep -w "exten => 1011,1,GotoIfTime" /var/dialplan/standard.conf | cut -d"," -f4`
                horaire="exten => s,1,$horaire1,$horaire2,*,*?opened,\${EXTEN},1)"
                echo "$horaire" >> /var/dialplan/ippi.conf
                echo "exten => s,n,Goto(closed,${EXTEN},1)" >> /var/dialplan/ippi.conf
                echo "[opened]" >> /var/dialplan/ippi.conf
                echo "exten => s,1,Dial(dahdi/2/30) && Dial(SIP/$1,15,tT)" >> /var/dialplan/ippi.conf
                echo "[closed]" >> /var/dialplan/ippi.conf
                echo "exten => s,1,Answer()" >> /var/dialplan/ippi.conf
                echo "exten => s,n,Playtones(busy)" >> /var/dialplan/ippi.conf
                echo "exten => s,n,Busy(5)" >> /var/dialplan/ippi.conf
                echo "exten => s,n,Hangup" >> /var/dialplan/ippi.conf
                
        elif [ "$proposition_svi_3" == "composer" ];then
                echo "exten => 3,1,Background(IVR-008)" >> /var/dialplan/ippi.conf
                echo "exten => 3,2,Read(ext,\"\",4)" >> /var/dialplan/ippi.conf
                echo "exten => 3,3,Goto(svi,\${ext},1)" >> /var/dialplan/ippi.conf
        elif [ "$proposition_svi_3" == "callcenter" ];then
                num_call=`grep -w -n "the $nom_call queue" /var/dialplan/callcenter.conf | cut -d" " -f3 | cut -d"," -f1`
                echo "exten => 1,1,Goto(Queues,$num_call,1)" >> /var/dialplan/ippi.conf
        else
                echo "exten => 3,1,Dial(SIP/$proposition_svi_3)" >> /var/dialplan/ippi.conf
        fi

        echo "exten => _[3-9#],1,Goto(from_ippi,s,3)" >> /var/dialplan/ippi.conf
        echo "exten => t,1,Goto(from_ippi,s,3)" >> /var/dialplan/ippi.conf
        echo ";fin $receiver"_"$num1"_"$num2"_"$num3" >> /var/dialplan/ippi.conf
        
elif [ "$choix" == "2" ];then
        #l'admin a choisi le standard
        echo $p
        if [ "$num3" != "0" ];then
        sed ""$p1"i exten => s,"$p",GotoIf(\$[\${CUT(CUT(SIP_HEADER(TO),@,1),:,2)} = $num3]?"$receiver",s,1) ;"$receiver"_"$num1"_"$num2"_"$num3" +" /var/dialplan/ippi.conf > fichier.tmp && mv -f fichier.tmp /var/dialplan/ippi.conf; rm -f fichier.tmp
        let p++
        fi
        if [ "$num2" != "0" ];then
        sed ""$p1"i exten => s,"$p",GotoIf(\$[\${CUT(CUT(SIP_HEADER(TO),@,1),:,2)} = $num2]?"$receiver",s,1) ;"$receiver"_"$num1"_"$num2"_"$num3" +" /var/dialplan/ippi.conf > fichier.tmp && mv -f fichier.tmp /var/dialplan/ippi.conf; rm -f fichier.tmp
        let p++
        fi
        if [ "$num1" != "0" ];then
        sed ""$p1"i exten => s,"$p",GotoIf(\$[\${CUT(CUT(SIP_HEADER(TO),@,1),:,2)} = $num1]?"$receiver",s,1) ;"$receiver"_"$num1"_"$num2"_"$num3" +" /var/dialplan/ippi.conf > fichier.tmp && mv -f fichier.tmp /var/dialplan/ippi.conf; rm -f fichier.tmp
        let p++
        fi
        echo ";$receiver"_"$num1"_"$num2"_"$num3" >> /var/dialplan/ippi.conf
        echo "[$receiver]" >> /var/dialplan/ippi.conf
        standard=`grep -w "exten => 1011,1,Dial(SIP" /var/dialplan/standard.conf | cut -d"," -f3 | cut -d"/" -f2`
        horaire1=`grep -w "exten => 1011,1,GotoIfTime" /var/dialplan/standard.conf | cut -d"," -f3`
        horaire2=`grep -w "exten => 1011,1,GotoIfTime" /var/dialplan/standard.conf | cut -d"," -f4`
        horaire="exten => s,1,$horaire1,$horaire2,*,*?opened,\${EXTEN},1)"
        echo "$horaire" >> /var/dialplan/ippi.conf
        echo "exten => s,n,Goto(closed,\${EXTEN},1)" >> /var/dialplan/ippi.conf
        echo "[opened]" >> /var/dialplan/ippi.conf
        echo "exten => s,1,Dial(dahdi/2/30) && Dial(SIP/$1,15,tT)" >> /var/dialplan/ippi.conf
        echo "[closed]" >> /var/dialplan/ippi.conf
        echo "exten => s,1,Answer()" >> /var/dialplan/ippi.conf
        echo "exten => s,n,Playtones(busy)" >> /var/dialplan/ippi.conf
        echo "exten => s,n,Busy(5)" >> /var/dialplan/ippi.conf
        echo "exten => s,n,Hangup" >> /var/dialplan/ippi.conf  
        receiver="standard"
        echo ";fin $receiver"_"$num1"_"$num2"_"$num3" >> /var/dialplan/ippi.conf

else
        #l'admin a choisi un utilisateur
        echo $p
        if [ "$num3" != "0" ];then
        sed ""$p1"i exten => s,"$p",GotoIf(\$[\${CUT(CUT(SIP_HEADER(TO),@,1),:,2)} = $num3]?"$receiver",s,1) ;"$receiver"_"$num1"_"$num2"_"$num3" +" /var/dialplan/ippi.conf > fichier.tmp && mv -f fichier.tmp /var/dialplan/ippi.conf; rm -f fichier.tmp
        let p++
        fi
        if [ "$num2" != "0" ];then
        sed ""$p1"i exten => s,"$p",GotoIf(\$[\${CUT(CUT(SIP_HEADER(TO),@,1),:,2)} = $num2]?"$receiver",s,1) ;"$receiver"_"$num1"_"$num2"_"$num3" +" /var/dialplan/ippi.conf > fichier.tmp && mv -f fichier.tmp /var/dialplan/ippi.conf; rm -f fichier.tmp
        let p++
        fi
        if [ "$num1" != "0" ];then
        sed ""$p1"i exten => s,"$p",GotoIf(\$[\${CUT(CUT(SIP_HEADER(TO),@,1),:,2)} = $num1]?"$receiver",s,1) ;"$receiver"_"$num1"_"$num2"_"$num3" +" /var/dialplan/ippi.conf > fichier.tmp && mv -f fichier.tmp /var/dialplan/ippi.conf; rm -f fichier.tmp
        let p++
        fi
        echo ";$receiver"_"$num1"_"$num2"_"$num3" >> /var/dialplan/ippi.conf
        echo "[$receiver]" >> /var/dialplan/ippi.conf
        echo "exten => s,1,Dial(SIP/$receiver,15,tT)" >> /var/dialplan/ippi.conf
        echo ";fin $receiver"_"$num1"_"$num2"_"$num3" >> /var/dialplan/ippi.conf
fi

asterisk -rx "reload"