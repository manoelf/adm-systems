#!/bin/bash 
#=======================================================#
# Aluno: Jose Manoel Ferreira                           #
# Prof: Matheus G. Rego                                 #
#                                                       #
# Oitava atividade.                                     #
#=======================================================#


domains=$(mktemp)
IPS=0

# cetralizando as entradas em um unico arquivo
echo $1 > $domains

if [ $1 == "-f" ];then 
    cat $2 > $domains
fi

# iterando sobre o os nomes e resolvendo
while read line; do
    #Contando todos os ips
    IPS=$(getent hosts $line | wc -l)

    # obtendo o tempo de consulta
    runtime=$(/usr/bin/time -p -o time getent hosts $line)
    runtime=$(cat time | head -1 | cut -d " " -f2)
    if [ $IPS -gt 0 ]; then
        # verificacao se ha versao mobile
        time=$(getent hosts "m.$line")
        if [ $? -eq 0 ]; then
            echo "$line $IPS MOBILE time=$runtime"
        else 
            echo "$line $IPS time=$runtime"
        fi
    else 
        echo $line "ERRO"
    fi

done < $domains

# remocao de arquivos auxiliares
rm $domains
rm time

# extra: tempo para resolucao de nome


