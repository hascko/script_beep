#!/bin/bash

user=$1

sed -i "/\;$user/,/\;fin $user/d" /var/user/general.conf
sed -i "/\;$user/,/\;fin $user/d" /var/dialplan/ippi.conf
sed -i "/\;$user/,/\;fin $user/d" /var/user/ippi.conf
sed -i "/\;$user/,/\;fin $user/d" /var/dialplan/travail.conf

asterisk -rx "dialplan reload"