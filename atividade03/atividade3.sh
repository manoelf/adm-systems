#!/bin/bash

exercicio=$1
aluno=$2

#Concatenando para obeter o script
script=$(echo $exercicio'_'$aluno'.sh')

#Alterando as permissoes para poder executar o script
chmod +x $script

entrada=$exercicio'.in'
saida=$exercicio'.out'

./$script <  $entrada > result


diff result $saida > dif


echo "$exercicio'_X_'$aluno:"

echo "-SAIDA PARA A ENTRADA X:"
cat result

echo 

echo "-DIFERENCA PARA A SAIDA ESPERADA:" 
echo $(grep '>' dif)



