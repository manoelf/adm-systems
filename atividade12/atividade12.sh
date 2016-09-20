#!/bin/bash

   
#tar -cvzf "$2$BKP_NAME" $1

function rename_folder {

    if [ -d "$1" ];then
        version=$(echo $1 | cut -d "." -f2)
        file_name=$(echo $1 | cut -d "." -f1)
        if [ "$1" == "$version" ];then
            #version=$(($version+1))
            rename_folder "$file_name.1"
        else
            version=$(($version+1))
            rename_folder "$file_name.$version"
        fi
    else
        echo "$1"
    fi
}
var=$(echo $1 | rev | cut -d "/" -f2 | rev)
echo $var
FOLDER_NAME=$(rename_folder "$2$var")
echo $FOLDER_NAME
#rename_folder $1
cp -R $1 $FOLDER_NAME

