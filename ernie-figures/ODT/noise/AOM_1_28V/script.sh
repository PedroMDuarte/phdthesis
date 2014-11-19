file=17
filename='DAQ'

for((i=1;i<8;i++))
do
bash trim.sh $file-0$i.ASC
bash toPSU.sh $file-0$i.dat
done


for((j=1;j<7;j++))
do
bash truncate.sh $file-0$((j+1)).data $file-0$j.data
done

cp $file-07.data $file-07.dat

for ((i=7;i>0;i--))
do
less $file-0$i.dat>>$filename.dat

done 




