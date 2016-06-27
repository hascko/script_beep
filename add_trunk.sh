#!/bin/bash

compte=$1
passwd=$2
host=$3
port=$4
#=================================/var/user/general.conf=================
echo ";$compte"_"$host"_"$port" >> /var/user/general.conf
echo "register => $compte:$passwd@$host:$port" >> /var/user/general.conf
echo ";fin $compte"_"$host"_"$port" >> /var/user/general.conf

#===============================fin====================================

#=============================/var/user/ippi.conf=====================
echo ";$compte"_"$host"_"$port" >> /var/user/ippi.conf
echo "[outgoing_$compte"_"$host"_"$port]" >> /var/user/ippi.conf
echo "type=peer" >> /var/user/ippi.conf
echo "host=$host" >> /var/user/ippi.conf
echo "username=$compte" >> /var/user/ippi.conf
echo "secret=$passwd" >> /var/user/ippi.conf
echo "fromuser=$compte" >> /var/user/ippi.conf
echo "fromdomain=$host:$port" >> /var/user/ippi.conf
echo "nat=yes" >> /var/user/ippi.conf
echo "canreinvite=no" >> /var/user/ippi.conf
echo ";fin $compte"_"$host"_"$port" >> /var/user/ippi.conf
#=================================fin==============================
asterisk -rx "sip reload"