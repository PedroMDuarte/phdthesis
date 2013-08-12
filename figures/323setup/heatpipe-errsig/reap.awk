#Awk program that rescales and converts time to frequency
# type: awk -f reap.awk trace.dat

BEGIN {t1=0.48; t2=1.51;}

$1> -0.03 { print ($1-t1)*228.2/(t2-t1), $2 >> "scaled.dat"}





