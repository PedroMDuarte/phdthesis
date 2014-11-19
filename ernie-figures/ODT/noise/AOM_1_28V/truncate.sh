max=`awk 'BEGIN{max=0} NR>1 {if($1>max) max=$1; } END{print max} ' $1`
out=`echo $2|sed s/data/dat/`
awk -v max=$max '$1>max {print $1,$2}' $2>$out
