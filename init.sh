#!/bin/bash

set -e


appSetup () {
    touch /etc/samba/.alreadysetup

     # Samba init settings 

     cp -a  /etc/samba_orig/*  /etc/samba                   
     cp -a /var/lib/samba_orig/*  /var/lib/samba
}    

appStart () {
    [ -f /etc/samba/.alreadysetup ] && echo "Skipping setup..." || appSetup
    # Start the services
    /usr/bin/supervisord
}

appHelp () {
	echo "Available options:"
	echo " app:start          - Starts samba services"
	echo " app:setup          - First time setup."
	echo " app:help           - Displays the help"
	echo " [command]          - Execute the specified linux command eg. /bin/bash."
}

case "$1" in
	app:start)
		appStart
		;;
	app:setup)
		appSetup
		;;
	app:help)
		appHelp
		;;
	*)
		if [ -x $1 ]; then
			$1
		else
			prog=$(which $1)
			if [ -n "${prog}" ] ; then
				shift 1
				$prog $@
			else
				appHelp
			fi
		fi
		;;
esac

exit 0
