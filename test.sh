
a=( default 4 2 1 3 )

for i in {0..4..1}
 do 
 FILE=/home/ec2-user/${a[$]}/text.txt
if test -f "$FILE"; then
    echo "$FILE exist"
fi