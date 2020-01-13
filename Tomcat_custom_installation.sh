#remove previously installed tomcat

#Check if tomcat is already present
var=$(sudo find / -name "version.sh")

if [[ -z "$var" ]];then
echo "Tomcat isn't already present installing it now"
#else do you want to remove previous tomcat?
else
read -p "Tomcat is already installed do you want to delete it and proceed for new installation [y/n]:" dpt
y=$(echo $var1 | tr -s '[:upper:]' '[:lower:]')
if [[ "$dpt" = "y" ]] ; then
var3=${var%/*}
path=${var3%/*}
echo "$path"
sudo rm -rf $path
fi
fi

#Install new tomcat if older version is deleted
var_t=$(sudo find / -name "version.sh")
if [[ -z "$var_t" ]];then
read -p "do you want to install tomcat in new directory?[y/n]:" a



y=$(echo $var1 | tr -s '[:upper:]' '[:lower:]')
if [[ "$dpt" = "y" ]] ; then



read -p "enter the directory of new tomcat[directory starting with /]:" dir
mkdir $dir
cd $dir

else 
read -p "enter the path of existing directory in which you want to install tomcat [directory starting with /]:" dir
cd $dir

fi
fi


#tomcat installation 


#installing java
sudo yum install java



#downloading tomcat
wget http://apachemirror.wuchna.com/tomcat/tomcat-8/v8.5.50/bin/apache-tomcat-8.5.50-windows-x64.zip

#unzipping tar file 
tar -xvzf apache-tomcat-8.5.49.tar.gz


read -p "do you want to delete the zip file [enter y/n]:" var1

y=$(echo $var1 | tr -s '[:upper:]' '[:lower:]')

if [[ "$var1" = "y" ]] ; then

#remove tomcat downloaded tar file
rm -rf apache-tomcat-8.5.49.tar.gz
fi

read -p "Do you want to change port for tomcat [enter y/n]:" var2

y=$(echo $var2 | tr -s '[:upper:]' '[:lower:]')

if [[ "$var2" = "y" ]] ; then
read -p "Enter the new port:" port
#changing the port for tomcat
sed -i "s/port=\"8080\"/port=\"$port\"/" apache-tomcat-8.5.49/conf/server.xml
else
port=8080
fi
#creating users in tomcat-users.xml

sed -i 's\</tomcat-users>\<!-- -->\g' apache-tomcat-8.5.49/conf/tomcat-users.xml

read -p "Do you want to use default username and password for manager_script and manager_gui [enter y/n]:" var3

n=$(echo $var3 | tr -s '[:upper:]' '[:lower:]')

if [[ "$var3" = "n" ]] ; then
read -p "Enter username for manager-script :" user_script
read -p "Enter password for manager-script :" pwd_script
read -p "Enter username for manager-GUI :" user_gui
read -p "Enter password for manager-GUI :" pwd_gui





echo '<role rolename="manager-gui" />' >> apache-tomcat-8.5.49/conf/tomcat-users.xml
echo "<user username=\"$user_gui\" password=\"$pwd_gui\" roles=\"manager-gui\" />" >> apache-tomcat-8.5.49/conf/tomcat-users.xml
echo '<role rolename="manager-script" />' >> apache-tomcat-8.5.49/conf/tomcat-users.xml
echo "<user username=\"$user_script\" password=\"$pwd_script\" roles=\"manager-script\" />" >> apache-tomcat-8.5.49/conf/tomcat-users.xml
echo '</tomcat-users>' >> apache-tomcat-8.5.49/conf/tomcat-users.xml


else



echo "The default username/password for manager-script are {script/script}"

echo "The default username/password for manager-script are {admin/admin}"

echo '<role rolename="manager-gui" />' >> apache-tomcat-8.5.49/conf/tomcat-users.xml
echo '<user username="admin" password="admin" roles="manager-gui" />' >> apache-tomcat-8.5.49/conf/tomcat-users.xml
echo '<role rolename="manager-script" />' >> apache-tomcat-8.5.49/conf/tomcat-users.xml
echo '<user username="script" password="script" roles="manager-script" />' >> apache-tomcat-8.5.49/conf/tomcat-users.xml
echo '</tomcat-users>' >> apache-tomcat-8.5.49/conf/tomcat-users.xml

fi

#setting valve in comments

sed -i 's/<Valve /<!-- <Valve /' apache-tomcat-8.5.49/webapps/manager/META-INF/context.xml

sed -i 's\:1" />\:1" /> -->\g' apache-tomcat-8.5.49/webapps/manager/META-INF/context.xml



#running tomcat
apache-tomcat-8.5.49/bin/./startup.sh

echo "tomcat is running on port : $port"
