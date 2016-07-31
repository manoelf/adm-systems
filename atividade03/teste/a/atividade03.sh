#!/bin/bash


exercicio=$1
aluno=$2


#pegando todos os arquivos
ls >  arquivos

#removendo o meu script dentre os arquivos
sed -i '/atividade03.sh/d' arquivos


#caso receba dois ou menos parametros
if [ $# -eq 2 ]; then
    script=$(echo 'EXERCICIO_'$exercicio'_'$aluno'.sh')
    echo $script > scripts
else
    grep '.sh' arquivos  > scripts
fi

#salvando todas as entradas e saidas dos testes
grep '.in' arquivos > entradas
grep '.out' arquivos > saidas

while read line; do
    #se nao receber parametros, pega todas as atividades da vez
    if [ $# -eq 0 ]; then
        exercicio=$(echo $line | cut -d '_' -f 2)
    fi

    #Aterando as permissoes do script para poder testa-lo
    chmod +x $line

    #quantidade de vezes que sera testado
    testes=$(cat entradas | wc -l)
    echo $(echo $line | cut -d '.' -f 1):

    for exer in $(seq $testes); do
    
        entrada='EXERCICIO_'$exercicio'_'$exer'.in'
        saida='EXERCICIO_'$exercicio'_'$exer'.out'
        ./$line <  $entrada > result         
   
 
        diff result $saida > dif

        echo "- SAIDA PARA ENTRADA $exer:"
        cat result

        echo 

        echo "- DIFERENCA PARA A SAIDA ESPERADA:" 
        grep '>' dif > out
        cat out
    
        echo

    done
done < scripts


rm arquivos
rm scripts
rm entradas
rm saidas
rm result
rm dif
rm out
