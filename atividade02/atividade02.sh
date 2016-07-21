#!/bin/bash
#=======================================================#
# Aluno: Jose Manoel Ferreira                           #
# Prof: Matheus G. Rego                                 #
#                                                       #
# Segunda atividade. Praticas de shell script           #
#=======================================================#

# se não passar parametros ler as entradas
if [ $# -eq 0 ];
then
    read obs;
    read intervalo;
    read nome;
else
    obs=$1
    intervalo=$2
    nome=$3
fi

#Validacoes para as entradas
if [ $obs -lt 0 ]
then
    exit 1;
elif [ $intervalo -lt 0 ]
then
    exit 1;
fi


CPU=0.0
MEM=0.0
minCPU=10000000.0
maxCPU=0.0
minMEM=10000000.0
maxMEM=0.0

#
for i in $(seq $obs);do
    #salvando todos os processos
    ps aux  > file
    #removendo os que nao tem o user dado em nome
    sed -i "/^$nome/!d" file
    while read line
    do
        #Pegando os processos (extra)
        echo ${line##* } >> comandos
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
    #eperando o tempo dado com entrada
    sleep $intervalo
done

echo "Valor total em % da  CPU $CPU"
echo "Valor minimo em % da CPU $minCPU"
echo "Valor maximo em % da  CPU $maxCPU"
echo ""
echo "Valor total de memoria usado nos processos do usuario especificado em % $MEM"
echo "Menor valor de memoria usada em % $minMEM"
echo "Maior valor de memoria usado em % $maxMEM"

echo "Voce deseja ver os comados de cada processo que foram analizados? (sim/nao)"
read opcao

#Mostrando todos os comando de cada processo do usario especificado
if [ "$opcao" = "sim" ]
then
    cat comandos;
fi

echo "" > comandos
rm comandos
rm file
