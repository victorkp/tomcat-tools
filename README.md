## Server Tools ##
Some scripts to help get a Tomcat and MySQL server up and running, as well as deploy code through SSH.

## Usage ##
install-server.sh can install Tomcat and MySQL on Fedora/Redhat and Ubuntu/Debian distributions, as well as start the appropriate services at startup.

deploy.sh will deploy a WAR file to a server through SSH. It's assumed you have a server with Tomcat installed, as well as a certificate to SSH into the server with. After deploying, the script asks if it should save the credentials you enter, for faster use next time.
./deploy.sh \<WAR FILE\>


