output=`echo $1|sed s/ASC/dat/`
awk -f trim.awk $1 > $output
