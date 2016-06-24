#!/bin/bash

context2=$1
context=$2

echo "include => $context " >> /var/dialplan/$context2.conf

verif2=`grep -w "\#include \"/var/dialplan/$context2.conf\"" /var/dialplan/$context.conf`

echo "include => $context2 " >> /var/dialplan/$context.conf

asterisk -rx "dialplan reload"