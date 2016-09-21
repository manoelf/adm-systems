#!/bin/bash

   
#tar -cvzf "$2$BKP_NAME" $1

function rename_folder {

    if [ -e "$1" ];then
        version=$(echo $1 | rev | cut -d "." -f1 | rev)
        file_name=$(echo $1 | rev | cut -d "." -f2- | rev)
        if [ "$1" == "$version" ];then
            rename_folder "$file_name.1"
        elif [ $version -gt 0 ];then
            version=$(($version+1))
            rename_folder "$file_name.$version"
        else 
            rename_folder "$file_name.$version.1"
        fi
    else
        echo "$1"
    fi
}





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

function exist {
    version=1
    while [ -e $1"."$version ];do
        version=$(($version+1))
   
    done

    echo $1"."$version
}


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



if [ "$1" == "-z" ];then
    if [ 
    var=$(get_name $2 $3)
    version=$(echo $var | rev | cut -d "." -f1 | rev)
    name=$(echo $var | rev | cut -d "." -f2- | rev)
    result=$(put_extension $2 $3)
    
    tar -cvzf $result $2
    echo "$result" >> info 
    date >> info
else
    var=$(get_name $1 $2)

    cp -R $1 $var
    echo "$var" >> info
    date >> info
fi

