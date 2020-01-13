

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
sudo touch /etc/init.d/tomcat
sudo su 
cat > /etc/init.d/tomcat << EOF
export JAVA_HOME=/usr/java/latest
 
#Add Java binary files to PATH
export PATH=$JAVA_HOME/bin:$PATH
 
#CATALINA_HOME is the location of the bin files of Tomcat  
export CATALINA_HOME=/home/ec2-user/apache-tomcat-8.5.50
 
#CATALINA_BASE is the location of the configuration files of this instance of Tomcat
export CATALINA_BASE=$CATALINA_HOME
 
#TOMCAT_USER is the default user of tomcat
export TOMCAT_USER=tomcat


#TOMCAT_USAGE is the message if this script is called without any options
TOMCAT_USAGE="Usage: $0 {\e[00;32mstart\e[00m|\e[00;31mstop\e[00m|\e[00;31mkill\e[00m|\e[00;32mstatus\e[00m|\e[00;31mrestart\e[00m}"
 
#SHUTDOWN_WAIT is wait time in seconds for java proccess to stop
SHUTDOWN_WAIT=20
 
tomcat_pid() {
        echo `ps -fe | grep $CATALINA_BASE | grep -v grep | tr -s " "|cut -d" " -f2`
}
 
start() {
  pid=$(tomcat_pid)
  if [ -n "$pid" ]
  then
    echo -e "\e[00;31mTomcat is already running (pid: $pid)\e[00m"
  else
    # Start tomcat
    echo -e "\e[00;32mStarting tomcat\e[00m"
    #ulimit -n 100000
    #umask 007
    #/bin/su -p -s /bin/sh $TOMCAT_USER
        if [ `user_exists $TOMCAT_USER` = "1" ]
        then
                /bin/su $TOMCAT_USER -c $CATALINA_HOME/bin/startup.sh
        else
                echo -e "\e[00;31mTomcat user $TOMCAT_USER does not exists. Starting with $(id)\e[00m"
                sh $CATALINA_HOME/bin/startup.sh
        fi
        status
  fi
  return 0
}
 
status(){
          pid=$(tomcat_pid)
          if [ -n "$pid" ]
            then echo -e "\e[00;32mTomcat is running with pid: $pid\e[00m"
          else
            echo -e "\e[00;31mTomcat is not running\e[00m"
            return 3
          fi
}

terminate() {
	echo -e "\e[00;31mTerminating Tomcat\e[00m"
	kill -9 $(tomcat_pid)
}

stop() {
  pid=$(tomcat_pid)
  if [ -n "$pid" ]
  then
    echo -e "\e[00;31mStoping Tomcat\e[00m"
    #/bin/su -p -s /bin/sh $TOMCAT_USER
        sh $CATALINA_HOME/bin/shutdown.sh
 
    let kwait=$SHUTDOWN_WAIT
    count=0;
    until [ `ps -p $pid | grep -c $pid` = '0' ] || [ $count -gt $kwait ]
    do
      echo -n -e "\n\e[00;31mwaiting for processes to exit\e[00m";
      sleep 1
      let count=$count+1;
    done
 
    if [ $count -gt $kwait ]; then
      echo -n -e "\n\e[00;31mkilling processes didn't stop after $SHUTDOWN_WAIT seconds\e[00m"
      terminate
    fi
  else
    echo -e "\e[00;31mTomcat is not running\e[00m"
  fi
 
  return 0
}
 
user_exists(){
        if id -u $1 >/dev/null 2>&1; then
        echo "1"
        else
                echo "0"
        fi
}
 
case $1 in
	start)
	  start
	;;
	stop)  
	  stop
	;;
	restart)
	  stop
	  start
	;;
	status)
		status
		exit $?  
	;;
	kill)
		terminate
	;;		
	*)
		echo -e $TOMCAT_USAGE
	;;
esac    
exit 0
EOF



sudo chmod +x tomcat