#getting the total number of files
read -p "Enter total number of files" nf

#Getting the file names
read -p  "Enter $nf file names seperated by space: [enter return only after you have given all file names] " -a a

#folder array
f=( default 4 2 1 3 )

#create a text file for storing path
sudo cat  > result.txt

#check files name wise
i=0
j=0
while [ $i -lt $nf ]
  do 
  while [ $j -lt 5 ]
    do 
    file=/home/ec2-user/${f[$j]}/${a[$nf]}
    if test -f "$file" ; then
     echo "${a[$i]} :: $file" >> result.txt
     break
   done
 $i = 'expr $i+1'
done  