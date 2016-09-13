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
echo "Do you want download all files fo folders and as a git a lot of index.html files? :)  (yes/no)"
read answer

while read line; do
    file=$(echo $line | cut -d '"' -f2)
    if [[ $file != *"/"* ]]; then
        wget "$1/$file" 
    fi
    if [ "$answer" == "yes" ];then 
        wget -r -nd "$1/$file"
    fi
done < file

rm files
rm file
