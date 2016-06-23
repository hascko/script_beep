#!/bin/bash

context2=$1
context=$2

verif=`grep -w "\#include \"/var/dialplan/$context.conf\"" /var/dialplan/$context2.conf`

#if [ -z "$verif" ];then
	#sed "1i#include \"/var/dialplan/$context.conf\"" /var/dialplan/$context2.conf > fichier.tmp && mv -f fichier.tmp /var/dialplan/$context2.conf; rm -f fichier.tmp
	echo "include => $context " >> /var/dialplan/$context2.conf
#fi

verif2=`grep -w "\#include \"/var/dialplan/$context2.conf\"" /var/dialplan/$context.conf`

#if [ -z "$verif2" ];then
	#sed "1i#include \"/var/dialplan/$context2.conf\"" /var/dialplan/$context.conf > fichier.tmp && mv -f fichier.tmp /var/dialplan/$context.conf; rm -f fichier.tmp
	echo "include => $context2 " >> /var/dialplan/$context.conf
#fi

asterisk -rx "dialplan reload"