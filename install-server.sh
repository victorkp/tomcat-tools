#!/bin/bash

echo Which Linux distribution are you using? Enter 1, 2, or 3
select di in "Fedora" "Ubuntu" "Cancel"; do
	case $di in
		"Fedora" ) sudo yum install mysql-server tomcat tomcat-webapps tomcat-admin-webapps;
			sudo systemctl start mysqld.service;
			sudo systemctl enable tomcat.service;
			sudo systemctl start tomcat.service;
			echo;
			echo;
			echo "==STARTING-THE-SERVER==";
			echo "If you ever shutdown and restart your computer,";
			echo "you will need to start MySQL and Tomcat again, use the following:";
			echo "sudo systemctl start tomcat.service";
			echo "sudo systemctl start mysqld.service";
			echo "-----------------------";
			echo "";
			break;;
		"Ubuntu" ) sudo apt-get install mysql-server && sudo apt-get install mysql-client;
			sudo apt-get install tomcat7 && sudo apt-get install tomcat7-admin;
			sudo /etc/init.d/tomcat7 start;
			sudo /etc/init.d/mysql start;
			echo;
			echo;
			echo "==STARTING-THE-SERVER==";
			echo "Tomcat and MySQL Server are now installed!";
			echo "If you ever shutdown and restart your computer,";
			echo "you will need to start MySQL and Tomcat again, use the following:";
			echo "sudo /etc/init.d/tomcat7 start";
			echo "sudo /etc/init.d/mysqld start";
			echo "-----------------------";
			echo "";
			break;;
		"Cancel" ) exit;;
	esac
done

echo ""
echo "======MYSQL-SETUP======"
echo Note that you will need to configure MySQL priviledges
echo "\"GRANT PRIVILEGES.....\""
echo "-----------------------"
echo ""
echo ""
echo "===DEPLOYING--CODE====="
echo "You can deploy code through Tomcat manager"
echo "by navigating to http://localhost:8080"
echo "or by using deploy.sh (through ssh)
echo "-----------------------"
echo ""
echo ""
