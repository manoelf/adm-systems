#!/bin/bash

exercicio=$1
aluno=$2

#pegando todos os scripts
ls >  arquivos
grep '.sh' arquivos  > scripts
grep '.in' arquivos > entradas
grep '.out' arquivos > saidas



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
lines= $(cat entradas | wc -l)
for i in $(seq lines); do







rm arquivos
rm scripts
rm entradas
rm saidas
rm result
