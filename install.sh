#!/bin/sh


echo "#########################################################"
echo "Installation script for sibus framework"
echo "#########################################################"

INSTALL_SCRIPT="$( realpath "$0" )"
INSTALL_DIR="$( dirname "$INSTALL_SCRIPT" )"


if [ "$(whoami)" != "root" ]; then
	echo "Sorry, you are not root."
	exit 1
fi

echo " + Installing various useful packages"
sudo apt-get -y install python
sudo apt-get -y install git
sudo apt-get -y install jq
echo " + done"

echo " + Installing supervisor service"
sudo apt-get install supervisor
sudo cp -uv $INSTALL_DIR/supervisord.conf /etc/supervisor/supervisord.conf
sudo service supervisor restart
sudo service supervisor status
echo " + done. Now add config files in /etc/supervisor/conf.d/*.conf"

echo " + Github repositories:"
curl "https://api.github.com/users/picusalex/repos?per_page=100" | jq '.[] | .clone_url'


exit 0

#LINE=''
#FILE=lighttpd.conf
#grep -qF -- "$LINE" "$FILE" 

#|| echo "$LINE" >> "$FILE"