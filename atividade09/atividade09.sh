#!/bin/bash

#!/bin/bash
#=======================================================#
# Aluno: Jose Manoel Ferreira                           #
# Prof: Matheus G. Rego                                 #
#                                                       #
# Nona atividade. Sincronizando tempo com HTTP          #
#=======================================================#


(time wget --server-response --spider $1 -o out) 2> time

SEVER_TIME=$(grep "Date" out | tail -1 | cut -d " " -f8)

LOCAL_TIME=$(date | cut -d " " -f4)

RTT=$(grep "real" time | cut -d "m" -f2)

echo "Server Time" $SEVER_TIME
echo "Local Time" $LOCAL_TIME
echo "RTT" $RTT



function convert_to_seconds {
	hour=$(echo $1 | cut -d ":" -f1)
	min=$(echo $1 | cut -d ":" -f2)	
	sec=$(echo $1 | cut -d ":" -f3)

	total_time=$((($hour*60*60) + ($min*60) + $sec))
	
	echo $total_time
}



time1=$(convert_to_seconds $LOCAL_TIME) 
time2=$(convert_to_seconds $SEVER_TIME)
result=$(($time1 - $time2))

echo "Difference Time Between Local Time and Server Time: $result s"

echo "Actual date " $(date)
result=$(($time2 - $time1))
result=$(($result - 10800))

echo "Difference Time Without GTM Time: $result"

rm out
rm time

