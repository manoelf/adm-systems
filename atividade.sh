#!/bin/bash


wget http://ita.ee.lbl.gov/traces/calgary_access_log.gz -O acessfile.gz

gunzip acessfile.gz

sed -i '/ - - /!d' acessfile

remotes=0;
locals=0;

while read line
do
        if [[ $line == *"remote"* ]]
        then
                let remotes=$remotes+1;
        elif [[ $line == *"local"* ]]
        then
                let locals=$locals+1;
        fi
done < acessfile

echo "Total de requisicoes locais $locals"
echo "Total de requisicoes remotas $remotes"





