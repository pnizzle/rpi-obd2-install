#!/bin/sh

################################################################################
#
#    filename: rpi-obd2-install1.sh
# description: Script to install pyOBD on RPI2/3
#      author: Andre Mattie
#       email: devel@introsec.ca
#         GPG: 5620 A200 6534 B779 08A8  B22B 0FA6 CD54 93EA 430D
#     bitcoin: 1LHsfZrES8DksJ41JAXULimLJjUZJf7Qns
#        date: 03/24/2017
#
################################################################################

# variables
DIR="`pwd`"

# ensure script is run as root
if [ "$(id -u)" -ne "0" ] ; then
    echo "You must be root to run this script"
    exit 1
fi

# update, upgrade, and autoremove packages on system
function UPGRADE {
	apt-get  -y --allow-unauthenticated update && apt-get -y --allow-unauthenticated upgrade && apt-get -y  autoremove	
	exit 1
}

### prep script for reboot
cp rpi-obd2-install2.sh $DIR
cp rpi-obd2-install3.sh $DIR

function CONT1 {
	# add continuation to rc.local
	echo -e "#!/bin/sh -e" > /etc/rc.local
	echo -e "if [ -x $DIR/rpi-obd2-continue-2.sh ]" >> /etc/rc.local
	echo -e "then" >> /etc/rc.local
	echo -e "    sudo xterm -e $DIR/rpi-obd2-continue-2.sh" >> /etc/rc.local
	echo -e "fi" >> /etc/rc.local
	echo -e "exit 0" >> /etc/rc.local
}

# run update and upgrade
UPGRADE

# run install continuation 1
CONT1

# reboot system
reboot

exit 0
