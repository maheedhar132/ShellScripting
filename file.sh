#getting the total number of files
read -p "Enter total number of files" nf

#Getting the file names
read -p  "Enter $nf file names seperated by space: [enter return only after you have given all file names] " -a a

#folder array
f=( default 4 2 1 3 )

#create a text file for storing path
sudo cat  > result.txt

#check files name wise

j=4
for i in 'seq 0 $nf'
do 

	for j in 'seq 0 $j'
      	do
	 file=/home/ec2-user/${a[$i]}
	 if [[ -f "$file" ]] ; then
	 echo "${f[$j]} :: $file" >> result.txt
	fi
	done
done
	 