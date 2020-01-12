nf=4
a=( default 4 2 1 3 )
f=( text.txt text1.txt a.txt)
for i in {0..$nf..1}
 do 
 for j in {0..3..1}
 do
	 FILE=/home/ec2-user/${a[$i]}/${f[$j]}
 	 if test -f "$FILE"; then
	 echo "$FILE exist"
	 break
 	fi
 done
done