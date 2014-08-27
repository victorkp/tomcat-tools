#!/bin/bash

if [ "$#" -ne  1 ]; then
	# No arguments
	echo Error: you need to specify the web archive file!
	echo Usage: ./deploy-to-tomcat APP.war
	exit
fi

	# Declare some variables
	$vmname
	$username
	$password
	$saved

	if [ -e "$1" ]; then
		warname=$1

		# The .war file exists
		
		# Check if the credentials are saved already
		if [ -e "deploy-credentials.dat" ]; then
			# Read the vmname, username, and password from file

			echo Reading credentials saved in \"deploy-credentials.dat\"

			filecontent=$(cat deploy-credentials.dat)
			set $filecontent

			vmname=$1
			username=$2
			certificate=$3

			saved=1
		else
			# Request the vmname, username, and password

			echo Enter your server domain name:
			read vmname
			echo

			echo Enter your VM username:
			read username
			echo

			echo Enter the filename of your certificate:
			read certificate
			echo

		fi

		echo Uploading...
		scp -i ${certificate} $warname ${username}@${vmname}${warname}
		echo

		filename=$(basename ${warname} .war)

		echo Deploying to Tomcat...
			ssh -i ${certificate} -t ${username}@${vmname} "sudo rm -f /usr/local/tomcat/webapps/${filename}.war"
			ssh -i ${certificate} -t ${username}@${vmname} "sudo rm -r -f /usr/local/tomcat/webapps/$filename"
			ssh -i ${certificate} -t ${username}@${vmname} "sudo mv $warname /usr/local/tomcat/webapps/${filename}.war"
		echo

		echo Done!
		echo

		echo Your code is running at ${vmname}.cs.rutgers.edu:8080/${filename}
		echo
		echo

		#If the data is not already saved...
		if [ -e "deploy-credentials.dat" ]; then
			exit
		else
			# then ask to save data
			echo Would you like to save your VM Name/Username/Password for future use? Enter 1 or 2
			select yn in "Yes" "No"; do
				case $yn in
					Yes ) 	rm -f deploy-credentials.dat;
						echo "${vmname} ${username} ${password}" >> deploy-credentials.dat;
						echo Saved to file \"deploy-credentials.dat\";
						break;;
					No ) exit;;
				esac
			done
		fi

		exit
	fi

	echo Error: $1 does not exist
	echo Usage: ./deploy-to-tomcat APP.war
	exit
exit
