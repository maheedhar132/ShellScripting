

#Go to the folder in which you want to install tomcat
#installing java
sudo yum install java
#downloading tomcat
wget http://apachemirror.wuchna.com/tomcat/tomcat-8/v8.5.50/bin/apache-tomcat-8.5.50-windows-x64.zip
#unzipping tar file 
tar -xvzf apache-tomcat-8.5.49.tar.gz
#remove tomcat downloaded tar file
rm -rf apache-tomcat-8.5.49.tar.gz
#changing the port for tomcat
sed -i 's/port="8080"/port="8880"/' apache-tomcat-8.5.49/conf/server.xml

#creating users in tomcat-users.xml

sed -i 's\</tomcat-users>\<!-- -->\g' apache-tomcat-8.5.49/conf/tomcat-users.xml

echo '<role rolename="manager-gui" />' >> apache-tomcat-8.5.49/conf/tomcat-users.xml
echo '<user username="admin" password="admin" roles="manager-gui" />' >> apache-tomcat-8.5.49/conf/tomcat-users.xml
echo '<role rolename="manager-script" />' >> apache-tomcat-8.5.49/conf/tomcat-users.xml
echo '<user username="script" password="script" roles="manager-script" />' >> apache-tomcat-8.5.49/conf/tomcat-users.xml
echo '</tomcat-users>' >> apache-tomcat-8.5.49/conf/tomcat-users.xml

#setting valve in comments

sed -i 's/<Valve /<!-- <Valve /' apache-tomcat-8.5.49/webapps/manager/META-INF/context.xml

sed -i 's\:1" />\:1" /> -->\g' apache-tomcat-8.5.49/webapps/manager/META-INF/context.xml

#running tomcat
apache-tomcat-8.5.49/bin/./startup.sh
