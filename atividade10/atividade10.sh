#!/bin/bash
#=======================================================#
# Aluno: Jose Manoel Ferreira                           #
# Prof: Matheus G. Rego                                 #
#                                                       #
# Decima atividade: Seguranca                           #
#                                                       #
#=======================================================#


#Extra
#Caso passe um diretorio como parametro
#ira calcular o CMD de cada arquivo
if [ -d "$1" ]; then
    cd $1
    for arq in $(ls -w1); do
        if [ -f "$arq" ]; then 
            echo "$(cksum $arq) [CMD]"
        fi
    done
else

while read line; do
    
    hash_value=$(echo $line | cut -d " " -f1)
    algorithm=$(echo $line | cut -d " " -f2)
    file=$(echo ${line##*$algorithm })

    if [ -f "$file" ]; then
            if [ $algorithm == "CRC" ]; then 
                result=$(cksum $file | sed "s/ $file//g")
            elif [ $algorithm == "MD5" ]; then
                result=$(md5sum $file | sed "s/ $file//g")
            elif [ $algorithm == "SHA1" ]; then
                result=$(sha1sum $file | sed "s/ $file//g")
            fi
            
            
            if [ $result == $hash_value ];then 
                echo "OK $file"
            else 
                echo "ERROR $file"
            fi
    else 
        echo "NOT_FOUND $file"
    fi
               
done < $1
fi


