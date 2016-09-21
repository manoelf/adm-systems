#!/bin/bash

   
#tar -cvzf "$2$BKP_NAME" $1

function rename_folder {

    if [ -d "$1" ];then
        version=$(echo $1 | cut -d "." -f2)
        file_name=$(echo $1 | cut -d "." -f1-)
        if [ "$1" == "$version" ];then
            rename_folder "$file_name.1"
        else
            version=$(($version+1))
            rename_folder "$file_name.$version"
        fi
    else
        echo "$1"
    fi
}





function rename_file {
	if [ -e $1 ];then
		version=$(echo $1 | rev | cut -d "." -f1 | rev)
		file_name=$(echo $1 | rev | cut -d "." -f2- | rev)
		if [ "$1" == "$file_name.$version" ];then 
			rename_file  "$file_name.$version.1"
		else 
			version=$(($version+1))
			rename_file "$file_name.$version"
		fi
	else 
		echo "$1"
	fi
}

#cp -R $1 $FOLDER_NAME

if [ -f "$1" ];then 
	var=$(echo "$1" | rev | cut -d "/" -f1 | rev)
	FOLDER_NAME=$(rename_file "$2$var")
	echo $var
	echo $FOLDER_NAME
	echo "if"
elif [ -d "$1" ];then
	var=$(echo $1 | rev | cut -d "/" -f2 | rev)
	FOLDER_NAME=$(rename_folder "$2$var")
	echo $var
	echo $FOLDER_NAME
	echo "elif"
else
	echo "ERRADO!"
fi

cp -R $1 $FOLDER_NAME
#fodlName=$(rename_file "$2$var")
#echo $var
#echo $fodlName
