#!/bin/bash
#=======================================================#
# Aluno: Jose Manoel Ferreira                           #
# Prof: Matheus G. Rego                                 #
#                                                       #
# Setima atividade. Trabalhando com redes               #
#=======================================================#





pages=$1
hasWords=0
words=$2

if [ $# -eq 1 ];then
    words=$(mktemp)
fi

#Função para verificar se todas as palavras aparecem no site
function contains_word {
    wget -q -O site $1
    while read word; do
        lines=$(grep -i $word site | wc -l | cut -d " " -f1)
        echo $word $lines
        if [ $lines -gt 0 ]; then
            let hasWords=$hasWords+1;

        fi
    done < $words 
    wordsLines=$(wc -l $words | cut -d " " -f1)
    if [ $hasWords -eq $wordsLines ]; then
        if [ $hasWords -ne 0 ];then
            echo "OK!"
        fi
    fi
    rm site
}

#validacao do site e verificacao das ocorrencias das palavra se passado o segundo
#paramentro
while read line; do
    result=$(curl -s --head $line | head -n 1 | cut -d " " -f2);
    if [ $result -eq 200 ];then
        out=$(contains_word $line)
    fi

    echo  $line $result $out

done < $1

#Extra
#Eh mostrado quais palavras pesquisadas e a quantidade de vezes que aparecem

