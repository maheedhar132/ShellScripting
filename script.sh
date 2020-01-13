# creating folders

#default home directory 
home=/home/ec2-user
#Creating Default Folder
mkdir default
sudo $home/default/touch a.txt
sudo $home/default/touch c.txt
sudo $home/default/touch e.txt

# Creating folder 1
mkdir 1
sudo touch $home/1/b.txt
sudo touch $home/1/c.txt
sudo touch $home/1/f.txt

#Creating folder 2
mkdir 2
sudo touch $home/2/a.txt
sudo touch $home/2/c.txt
sudo touch $home/2/d.txt

#Creating folder 3
mkdir 3
sudo touch $home/3/g.txt
sudo touch $home/3/a.txt
sudo touch $home/3/d.txt

#Creating folder 4
mkdir 4
sudo touch $home/4/h.txt
sudo touch $home/4/a.txt
sudo touch $home/4/b.txt

#declaring array of files
a=( a.txt b.txt c.txt d.txt e.txt f.txt g.txt h.txt )

#Declaring array of folders
f=( default 4 2 1 3 )

# Display the files
for i in "${a[@]}"
 do 
  echo "$i "
 done






#check files name wise
for i in "${a[@]}"
 do 
 for j in "${f[@]}"
   do
   
    FILE=$home/$j/$i
    if test -f "$FILE"; then
       echo "$i	::	$FILE" >> result.txt
       break
    fi
   done
done	
echo "results stored in result.txt in file :: filepath format" 