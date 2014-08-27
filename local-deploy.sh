#!/bin/bash

if [ "$#" -ne 1 ]; then
	# No Arguments
	echo You need to specify the web archive file
	echo Usage: ./local-deploy APP.war
	exit
fi

warname=$1
filename=$(basename ${warname} .war)

echo
echo Removing old WAR
sudo rm -f /usr/share/tomcat/webapps/${filename}.war
echo
echo Copying new WAR
sudo cp $warname /usr/share/tomcat/webapps/${filename}.war
echo
echo Done!
echo
