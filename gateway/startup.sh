#!/bin/bash

if [ ! -f /etc/tahoe/private/aliases ]
then
	tahoe -d /etc/tahoe/ start
	tahoe -d /etc/tahoe/ create-alias tahoe
	tahoe -d /etc/tahoe/ stop
	sed -e 's/^tahoe: /tahoe passw0rd /g' /etc/tahoe/private/aliases > /etc/tahoe/private/ftp.accounts
	cat /etc/tahoe/tahoe.cfg-post >> /etc/tahoe/tahoe.cfg
fi

tahoe  start /etc/tahoe/ -l /var/log/tahoe.log -n