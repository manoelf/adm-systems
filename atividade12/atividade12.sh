#!/bin/bash

#=======================================++================#
# Student: Jose Manoel Ferreira                           #
# Professor: Matheus G. Rego                              #
#                                                         #
#12° Activity: backup                                     #
#                                                         #                                                       
#=========================================================#
   
#Função para auxiliar o tratamento do nome do arquivo ou diretorio 
function rename_file {
	if [ -e $1 ];then
		version=$(echo $1 | rev | cut -d "." -f1 | rev)
		file_name=$(echo $1 | rev | cut -d "." -f2- | rev)
		if [  "$version" == "$1" ];then 
			rename_file  "$file_name.1"
        elif [ $version -gt 0 ];then
            version=$(($version+1))
			rename_file "$file_name.$version"
        else 
            rename_file "$file_name.$version.1"
		fi
	else 
		echo "$1"
	fi
}

# Funcao para tratamento do nome
function get_name {
    if [ -f "$1" ];then 
	var=$(echo "$1" | rev | cut -d "/" -f1 | rev)
    	FOLDER_NAME=$(rename_file "$2$var")
	echo $FOLDER_NAME
    elif [ -d "$1" ];then
	var=$(echo $1 | rev | cut -d "/" -f2 | rev)
    	FOLDER_NAME=$(rename_file "$2$var")
    	echo $FOLDER_NAME
    fi

}

#validacao de existencia
function exist {
    version=1
    while [ -e $1"."$version ];do
        version=$(($version+1))
    done

    echo $1"."$version
}

#Colocando a extensao nos arquivos zipados
function put_extension {
    var=$(get_name $1 $2)
    version=$(echo $var | rev | cut -d "." -f1 | rev)
    name=$(echo $var | rev | cut -d "." -f2- | rev)
    result=$name".tar.gz"

    if [ -e $result ];then
        if [ "$name" == "$version" ];then
            result=$(exist $result)
        elif [ $version -gt 0 ];then 
            version=$(($version+1))
            result=$name"."$version
        else
            result=$result"."$version
        fi
    fi
    echo $result
    
}

#Valida entradas
function valid {
	if [ -d $1 ];then
		echo "$1/"
	elif [ -e $1 ];then
		echo $1
	else
		echo "ERRO" 
	fi
}


if [ "$1" == "-z" ];then
   	in1=$(valid $2)
	in2=$(valid $3) 
    var=$(get_name $in1 $in2)
	if [ $in1 == "ERRO" ] || [ $in2 == "ERRO" ];then
		exit 1;
	fi
    version=$(echo $var | rev | cut -d "." -f1 | rev)
    name=$(echo $var | rev | cut -d "." -f2- | rev)
    result=$(put_extension $in1 $in2)
    
    tar -cvzf $result $2
    echo "$result" >> info 
    date >> info
else
	in1=$(valid $1)
	in2=$(valid $2)
	if [ "$in1" == "ERRO" ] || [ "$in2" == "ERRO" ];then
		exit 1;
	fi
    var=$(get_name $in1 $in2)

    cp -R $in1 $var
    echo "$var" >> info
    date >> info
fi


