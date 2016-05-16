#!/bin/bash

compte=$1
passwd=$2
host=$3
num_geo=$4
num_sip=$5
num_inum=$6
user=$7

#=================================/var/user/general.conf=================
echo ";$user" >> /var/user/general.conf
echo "register => $compte:$passwd@$host" >> /var/user/general.conf
echo ";fin $user" >> /var/user/general.conf

#===============================fin====================================

#==========================/var/dialplan/ippi.conf===================
echo ";$user" >> /var/dialplan/ippi.conf
if [  ! -z $num_geo ];then
echo "exten => $num_geo,1,Dial(SIP/$user,20)" >> /var/dialplan/ippi.conf
fi
if [ ! -z $num_sip ];then
echo "exten => $num_sip,1,Dial(SIP/$user,20)" >> /var/dialplan/ippi.conf
fi
if [ ! -z $num_inum ];then
echo "exten => $num_inum,1,Dial(SIP/$user,20)" >> /var/dialplan/ippi.conf
fi
echo ";fin $user" >> /var/dialplan/ippi.conf
#==============================fin====================================

#=============================/var/user/ippi.conf=====================
echo ";$user" >> /var/user/ippi.conf
echo "[outgoing_$user]" >> /var/user/ippi.conf
echo "type=peer" >> /var/user/ippi.conf
echo "host=$host" >> /var/user/ippi.conf
echo "username=$compte" >> /var/user/ippi.conf
echo "secret=$passwd" >> /var/user/ippi.conf
echo "fromuser=$compte" >> /var/user/ippi.conf
echo "fromdomain=$host" >> /var/user/ippi.conf
echo "nat=yes" >> /var/user/ippi.conf
echo "canreinvite=no" >> /var/user/ippi.conf
echo ";fin $user" >> /var/user/ippi.conf
#=================================fin==============================

#================================/var/dialplan/travail.conf====================
echo ";$user" >> /var/dialplan/travail.conf
echo "exten => _X.,1,Dial(SIP/outgoing_$user/\${EXTEN})" >> /var/dialplan/travail.conf
echo ";fin $user" >> /var/dialplan/travail.conf
#==============================fin===========================================
asterisk -rx "dialplan reload"