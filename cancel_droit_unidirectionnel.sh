#!/bin/bash

context2=$1
context=$2

sed -i "/$context.conf/d" /var/dialplan/$context2.conf
sed -i "/$context/d" /var/dialplan/$context2.conf

asterisk -rx "dialplan reload"