#!/bin/bash


exercicio=$1
aluno=$2

#pegando todos os scripts
ls >  arquivos


grep '.in' arquivos > entradas

if [ $# -eq 2 ]; then
    cript=$(echo 'EXERCICIO_'$exercicio'_'$aluno'.sh')
    echo $script > scripts

else
    grep '.sh' arquivos  > scripts
fi

grep '.in' arquivos > entradas
grep '.out' arquivos > saidas

#Concatenando para obter o script
script=$(echo 'EXERCICIO_'$exercicio'_'$aluno'.sh')

#Aterando as permissoes do script
chmod +x $script

testes=$(cat entradas | wc -l)
echo "EXERCICIO_$exercicio_$aluno:"

for exer in $(seq $testes); do
    
    entrada='EXERCICIO_'$exercicio'_'$exer'.in'
    saida='EXERCICIO_'$exercicio'_'$exer'.out'
    ./$script <  $entrada > result         
   
 
    diff result $saida > dif

    echo "- SAIDA PARA ENTRADA $exer:"
    cat result

    echo 

    echo "- DIFERENCA PARA A SAIDA ESPERADA:" 
    grep '>' dif > out
    cat out
    
    echo

done



rm arquivos
rm scripts
rm entradas
rm saidas
rm result
rm dif
rm out
