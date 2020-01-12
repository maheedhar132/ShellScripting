#getting the total number of files
read -p "Enter total number of files: " nf

#Getting the file names
read -p  "Enter $nf file names seperated by space: [enter return only after you have given all file names] " -a a

#folder array
f=( default 4 2 1 3 )

#create a text file for storing path
sudo cat  > result.txt

#check files name wise
for i in {0..$nf..1}
 do 
 for j in {0..4..1}
  do 
   FILE=/home/ec2-user/${f[$j]}/${a[$i]}
   if test -f "$FILE"; then
      echo "$a[$i]	::	$FILE" >> result.txt
      break
   fi
   done
 done	 