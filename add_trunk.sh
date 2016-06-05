#!/bin/bash

compte=$1
passwd=$2
host=$3
num_geo=$4
num_sip=$5
num_inum=$6

#=================================/var/user/general.conf=================
echo ";$compte" >> /var/user/general.conf
echo "register => $compte:$passwd@$host" >> /var/user/general.conf
echo ";fin $compte" >> /var/user/general.conf

#===============================fin====================================

#=============================/var/user/ippi.conf=====================
echo ";$compte" >> /var/user/ippi.conf
echo "[outgoing_$compte]" >> /var/user/ippi.conf
echo "type=peer" >> /var/user/ippi.conf
echo "host=$host" >> /var/user/ippi.conf
echo "username=$compte" >> /var/user/ippi.conf
echo "secret=$passwd" >> /var/user/ippi.conf
echo "fromuser=$compte" >> /var/user/ippi.conf
echo "fromdomain=$host" >> /var/user/ippi.conf
echo "nat=yes" >> /var/user/ippi.conf
echo "canreinvite=no" >> /var/user/ippi.conf
echo ";fin $compte" >> /var/user/ippi.conf
#=================================fin==============================

#================================/var/dialplan/extern.conf====================
echo ";$compte" >> /var/dialplan/extern.conf
echo "[$compte]" >> /var/dialplan/extern.conf
echo "exten => _X.,1,Dial(SIP/outgoing_$compte/\${EXTEN})" >> /var/dialplan/extern.conf
echo ";fin $compte" >> /var/dialplan/extern.conf
#==============================fin===========================================
asterisk -rx "sip reload"
asterisk -rx "dialplan reload"