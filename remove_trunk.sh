#!/bin/bash

compte=$1

sed -i "/\;$compte/,/\;fin $compte/d" /var/user/general.conf
sed -i "/\;$compte/,/\;fin $compte/d" /var/user/ippi.conf
sed -i "/\;$compte/,/\;fin $compte/d" /var/dialplan/extern.conf

asterisk -rx "sip reload"
asterisk -rx "dialplan reload"