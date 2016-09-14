#!/bin/bash
#=======================================++================#
# Student: Jose Manoel Ferreira                           #
# Professor: Matheus G. Rego                              #
#                                                         #
#12° Activity: Sharing file and  using Python module      #
#(SimpleHTTPServer de Python 2 ou http.server de Python 3)#                                                       
#=========================================================#


curl -q -o files $1 # > files
grep "<li>" files > file

#Extra!
echo "Do you want download all files  and folders?   (yes/no)"
read answer

path=$(echo "$1" | cut -d "/" -f3)
actual_path=$(pwd)

while read line; do
    file=$(echo $line | cut -d '"' -f2)
    if [[ $file != *"/"* ]]; then
        wget "$1/$file" 
    fi
    if [ "$answer" == "yes" ];then 
        wget -r "$1/$file"
        mv $path/$file/ $actual_path 
    fi
done < file

rm files
rm file
rm -rf $path
find . -iname 'index.html*' -exec rm {} \;
