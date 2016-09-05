#!/bin/bash
#=======================================================#
# Aluno: Jose Manoel Ferreira                           #
# Prof: Matheus G. Rego                                 #
#                                                       #
# Decima atividade: Seguranca                           #
#                                                       #
#=======================================================#



while read line; do
    
    hash_value=$(echo $line | cut -d " " -f1)
    algorithm=$(echo $line | cut -d " " -f2)
    file=$(echo $line | cut -d " " -f3)
    #Problemas com arquivos de nome compostos 
    # o [ -e nomeArquivo ] nao reconhece
    filex=$(echo ${line##*$algorithm })

    if [ -e $file ]; then
            if [ $algorithm == "CRC" ]; then 
                result=$(cksum $file | sed "s/ $filex//g")
            elif [ $algorithm == "MD5" ]; then
                result=$(md5sum $file | sed "s/ $filex//g")
            elif [ $algorithm == "SHA1" ]; then
                result=$(sha1sum $file | sed "s/ $filex//g")
            fi
            
            
            if [ $result == $hash_value ];then 
                echo "OK $filex"
            else 
                echo "ERROR $filex"
            fi
    else 
        echo "NOT_FOUND $filex"
    fi
               
done < $1



