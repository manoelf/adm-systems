#!/bin/bash

CPUi=""
if [ $# -eq 0 ]; then     
    read obs;
    read intervalo;
    read nome;
else
    obs=$1
    intervalo=$2
    nome=$3
fi

#file=$(ps aux | grep "^$nome")

while read line
do
    valor=$(cat $linha |cut -d ' ' -f7)
    echo $valor
    i=$(bc -l <<< "$i + $valor")
    echo $i
#    echo "Aqui $CPU"

done < file



#echo "$obs $intervalo $nome"
echo "$CPUi bora bora aparecer"

