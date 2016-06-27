#!/bin/bash

arg=$#
if [ $# == 2 ]
        then
                sed -i -e "/include => $1 /d" /var/dialplan/$2.conf
fi
