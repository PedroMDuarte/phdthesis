file=12
filename='Servo_Background'

for((i=1;i<7;i++))
do
bash trim.sh $file-$i.ASC
bash toPSU.sh $file-$i.dat
done


for((j=1;j<6;j++))
do
bash truncate.sh $file-$((j+1)).data $file-$j.data
done

cp $file-6.data $file-6.dat

for ((i=6;i>0;i--))
do
less $file-$i.dat>>$filename.dat

done 




