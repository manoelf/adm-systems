#!/bin/bash
#=======================================++================#
# Student: Jose Manoel Ferreira                           #
# Professor: Matheus G. Rego                              #
#                                                         #
#13° Activity: centralized model configuration management #
#                                                         #                                                       
#=========================================================#






file_name=$(echo "$2" | rev | cut -d "/" -f1 | rev)


#Extra!!! verifica se ha arquivos com mesmo conteudo
function exist_similar {
    for line in /$2/*;do
        if [ -f "$line" ];then 
            result=$(diff $1 "$line")
            if [ "$result" == "" ];then
                echo "Exist a file with same content"
                exit 0;
            fi
        fi

    done

}

if [ "$1" == "-e" ];then
     if [ ! -e "$3$file_name" ];then
        cp $2 "$3$file_name"
    fi
#Find usado para verificar se ha arquivo nos 
#diretorios e subdiretorios
elif [ "$1" == "-s" ];then
    result=$(find . -iname $file_name)
    if [ "$result" == ""  ];then
        cp $2 "$3/$file_name"
    fi
#Verificacao se ha arquivo ou diretorio com
#o nome especificado
elif [ "$1" == "-d" ];then
    if [ -e "$3/$file_name" ];then
        if [ -d "$3$file_name" ];then 
            rm -rf $3
        else 
            rm  "$3$file_name"
        fi
    fi
#Verificacao se ha uma palavra no arquivo
elif [ "$1" == "-c" ];then
    contais=$(grep "$2" $3)
    if [ "$contains" == "" ];then
        echo "$2" >> $3
    fi
#Extra
elif [ "$1" == "-x" ];then
    exist_similar $2 $3
fi
