output=`echo $1|sed s/dat/data/`
awk -f toPSU.awk $1 > $output

