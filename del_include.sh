#!/bin/bash

arg=$#
if [ $# == 2 ]
        then
                sed -i -e "/include => $1 /d" $2.conf
fi
