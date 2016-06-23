#!/bin/bash

arg=$#
if [ $# == 2 ]
        then
                sed -i -e "/var\/dialplan\/$1.conf/d" $2.conf
fi
