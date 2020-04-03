#Go to the folder in which you want to install tomcat
#installing java
#sudo apt install java
#downloading tomcat
cd /home/ubuntu && sudo wget http://apachemirror.wuchna.com/tomcat/tomcat-8/v8.5.51/bin/apache-tomcat-8.5.51.tar.gz
#unzipping tar file 
tar -xvzf /home/ubuntu/apache-tomcat-8.5.51.tar.gz
#remove tomcat downloaded tar file
rm -rf /home/ubuntu/apache-tomcat-8.5.51.tar.gz
#changing the port for tomcat
sed -i 's/port="8080"/port="8880"/' /home/ubuntu/apache-tomcat-8.5.51/conf/server.xml

#creating users in tomcat-users.xml

sed -i 's\</tomcat-users>\<!-- -->\g' /home/ubuntu/apache-tomcat-8.5.51/conf/tomcat-users.xml

echo '<role rolename="manager-gui" />' >> /home/ubuntu/apache-tomcat-8.5.51/conf/tomcat-users.xml
echo '<user username="admin" password="admin" roles="manager-gui" />' >> /home/ubuntu/apache-tomcat-8.5.51/conf/tomcat-users.xml
echo '<role rolename="manager-script" />' >> /home/ubuntu/apache-tomcat-8.5.51/conf/tomcat-users.xml
echo '<user username="script" password="script" roles="manager-script" />' >> /home/ubuntu/apache-tomcat-8.5.51/conf/tomcat-users.xml
echo '</tomcat-users>' >> /home/ubuntu/apache-tomcat-8.5.51/conf/tomcat-users.xml

#setting valve in comments

sed -i 's/<Valve /<!-- <Valve /' /home/ubuntu/apache-tomcat-8.5.51/webapps/manager/META-INF/context.xml

sed -i 's\:1" />\:1" /> -->\g' /home/ubuntu/apache-tomcat-8.5.51/webapps/manager/META-INF/context.xml
