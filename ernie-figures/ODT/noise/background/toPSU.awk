BEGIN{df=1;}
{ if( NR == 1) buffer=$1; if (NR==2) df = $1-buffer}
{ print $1, $2/(df)^0.5 }

