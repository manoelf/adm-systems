#!/bin/bash

exercicio=$1
aluno=$2

#Concatenando para obter o script
script=$(echo 'EXERCICIO_'$exercicio'_'$aluno'.sh')

#Alterando as permissoes para poder executar o script
chmod +x $script

entrada='EXERCICIO_'$exercicio'.in'
saida='EXERCICIO_'$exercicio'.out'

./$script <  $entrada > result


diff result $saida > dif


echo "'EXERCICIO_'$exercicio'_'$aluno:"

echo "-SAIDA PARA A ENTRADA X:"
cat result

echo 

echo "-DIFERENCA PARA A SAIDA ESPERADA:" 
echo $(grep '>' dif)



