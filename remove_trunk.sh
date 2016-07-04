#!/bin/bash

compte=$1
host=$2
port=$3

sed -i "/\;$compte\_$host\_$port/,/\;fin $compte\_$host\_$port/d" /var/user/general.conf
sed -i "/\;$compte\_$host\_$port/,/\;fin $compte\_$host\_$port/d" /var/user/ippi.conf

asterisk -rx "reload"