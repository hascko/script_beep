#!/bin/bash

context2=$1
context=$2

echo "include => $context " >> /var/dialplan/$context2.conf

asterisk -rx "dialplan reload"