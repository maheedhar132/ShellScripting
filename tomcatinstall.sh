

#Go to the folder in which you want to install tomcat
#installing java
sudo yum install java
#downloading tomcat
wget http://mirrors.estointernet.in/apache/tomcat/tomcat-8/v8.5.50/bin/apache-tomcat-8.5.50.tar.gz
#unzipping tar file 
tar -xvzf apache-tomcat-8.5.50.tar.gz
#remove tomcat downloaded tar file
rm -rf apache-tomcat-8.5.50.tar.gz
#changing the port for tomcat
sed -i 's/port="8080"/port="8880"/' apache-tomcat-8.5.50/conf/server.xml

#creating users in tomcat-users.xml

sed -i 's\</tomcat-users>\<!-- -->\g' apache-tomcat-8.5.50/conf/tomcat-users.xml

echo '<role rolename="manager-gui" />' >> apache-tomcat-8.5.50/conf/tomcat-users.xml
echo '<user username="admin" password="admin" roles="manager-gui" />' >> apache-tomcat-8.5.50/conf/tomcat-users.xml
echo '<role rolename="manager-script" />' >> apache-tomcat-8.5.50/conf/tomcat-users.xml
echo '<user username="script" password="script" roles="manager-script" />' >> apache-tomcat-8.5.50/conf/tomcat-users.xml
echo '</tomcat-users>' >> apache-tomcat-8.5.50/conf/tomcat-users.xml

#setting valve in comments

sed -i 's/<Valve /<!-- <Valve /' apache-tomcat-8.5.50/webapps/manager/META-INF/context.xml

sed -i 's\:1" />\:1" /> -->\g' apache-tomcat-8.5.50/webapps/manager/META-INF/context.xml

#running tomcat
apache-tomcat-8.5.50/bin/./startup.sh

#Bootstrapping tomcat 
#sudo su
sudo touch /etc/init.d/tomcat8.sh

sudo echo "PATH=/sbin:/bin:/usr/sbin:/usr/bin" >> /etc/init.d/tomcat8.sh

sudo echo "start() {" >> /etc/init.d/tomcat8.sh
sudo echo " sh /usr/share/tomcat7/bin/startup.sh" >> /etc/init.d/tomcat8.sh
sudo echo "}" >> /etc/init.d/tomcat8.sh

sudo echo "stop() {" >> /etc/init.d/tomcat8.sh
sudo echo " sh /usr/share/tomcat7/bin/shutdown.sh" >> /etc/init.d/tomcat8.sh

sudo echo "}" >>/etc/init.d/tomcat8.sh

sudo echo "case $1 in" >> /etc/init.d/tomcat8.sh
sudo echo "  start|stop) $1;;" >> /etc/init.d/tomcat8.sh
sudo echo "  restart) stop; start;;" >> /etc/init.d/tomcat8.sh
sudo echo "  *) echo "Run as $0 <start|stop|restart>"; exit 1;;" >> /etc/init.d/tomcat8.sh
sudo echo "esac" >> /etc/init.d/tomcat8.sh


sudo chmod +x /etc/init.d/tomcat8.sh