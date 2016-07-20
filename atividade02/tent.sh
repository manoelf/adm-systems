#!/bin/bash


ps aux  > file
if [ $# -eq 0 ]; then         
    read obs;
    read intervalo;
    read nome;
else
    obs=$1
    intervalo=$2
    nome=$3
fi
sed -i "/$nome/!d" file

if [ $obs -lt 0 ]
then
    exit 0;
elif [ $intervalo -lt 0 ]
then
    exit 0;
fi


CPU=0.0
MEM=0.0
minCPU=1000.0
maxCPU=0.0
minMEM=1000.0
maxMEM=0.0
while read line
do
    valor=`echo $line | cut -d ' ' -f3`
    #minimo cpu
    if [ `echo "$valor < $minCPU" | bc` -eq 1 ]
    then
        minCPU=$valor
    fi


    CPU=$(bc -l <<< "$CPU + $valor")
    
    #maximo cpu
    if [ `echo "$valor > $maxCPU" | bc` -eq 1 ]
    then
        maxCPU=$valor
    fi
    valor=`echo $line | cut -d ' ' -f4`
    MEM=$(bc -l <<< "$MEM + $valor")
    
    #minimo memoria
    if [ `echo "$valor < $minMEM" | bc` -eq 1 ]
    then 
        minMEM=$valor  
    fi    

    #maximo memoria
    if [ `echo "$valor > $maxMEM" | bc` -eq 1 ]
    then
        maxMEM=$valor
    fi
done < file

echo "$CPU  CPU"
echo "$minCPU Menor CPU"
echo "$maxCPU Maior CPU"
echo "$MEM  MEM"
echo "$minMEM Menor MEM"
echo "$maxMEM Maior MEM"
